//
//  WebService.swift
//  FreelanceManager
//
//  Created by Teodik Abrami on 1/19/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import Foundation
import UIKit
import JWTDecode

class WebService {
    
    static let instance = WebService()
    typealias completion = (_ status: Alert) -> Void
    private let baseURL = URL.init(string: "151.242.182.159/")!
    private let head = ["Authorization":"Bearer" + " " + Authorization.shared.token,
                        "application/json":"application/json"
    ]
    private var device: Device {
        return Device.init(name: "Iphone", os: "ios", oSVersion: getOSInfo(), pusheID: "fcmtoken", brand: UIDevice.modelName)
    }
    
    public func register(email: String, fullName: String, password: String, completion: @escaping completion) {
        let url = baseURL.appendingPathComponent("register")
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonData = [
            "fullname":"test",
            "email":"test",
            "password":"test",
            "osVersion":device.oSVersion,
            "devModel":device.brand,
            "fcmToken":device.pusheID,
            "platformID":"1"
        ]
        let jsonEncoder = JSONEncoder()
        let json = try? jsonEncoder.encode(jsonData)
        request.httpBody = json
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(.failed)
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                guard let register = try? decoder.decode(Register.self, from: data) else { completion(.failed) ; return }
                print(register)
                self.decodeJWT(token: register.token)
                completion(.success)
            } else {
                completion(.failed)
            }
        }
        task.resume()

        
    }

    
    //private
    
    private func getOSInfo() -> String {
        let os = ProcessInfo().operatingSystemVersion
        return String(os.majorVersion) + "." + String(os.minorVersion) + "." + String(os.patchVersion)
    }
    
    private func getPlatformNSString() -> String {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
        let DEVICE_IS_SIMULATOR = true
        #else
        let DEVICE_IS_SIMULATOR = false
        #endif
        var machineSwiftString : String = ""
        if DEVICE_IS_SIMULATOR == true
        {
            // this neat trick is found at http://kelan.io/2015/easier-getenv-in-swift/
            if let dir = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                machineSwiftString = dir
                return machineSwiftString
            }
        } else {
            var size : size_t = 0
            sysctlbyname("hw.machine", nil, &size, nil, 0)
            var machine = [CChar](repeating: 0, count: Int(size))
            sysctlbyname("hw.machine", &machine, &size, nil, 0)
            machineSwiftString = String.init(cString: machine)
            return machineSwiftString
            
        }
        print("machine is \(machineSwiftString)")
        return machineSwiftString
    }
    
    private func decodeJWT(token: String) {
        guard let jwt = try? decode(jwt: token) else { return }
        let userId = jwt.claim(name: "userID").string ?? ""
        let status = jwt.claim(name: "status").string ?? ""
        let iat = jwt.claim(name: "iat").string ?? ""
        print(userId,status,iat)
    }
    
    private func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    private func createDataBody(withParameters parameters: [String: String]?, media: Data?, boundary: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        if let parameters = parameters {
            for (key,value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }
        if let media = media {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"Avatar\"; filename=\"\("\(arc4random())" + ".jpeg")\"\(lineBreak)")
            body.append("Content-Type: \(".jpeg" + lineBreak + lineBreak)")
            body.append(media)
            body.append(lineBreak)
        }
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
}

