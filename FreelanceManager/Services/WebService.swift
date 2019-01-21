//
//  WebService.swift
//  FreelanceManager
//
//  Created by Teodik Abrami on 1/19/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import Foundation
import UIKit


class WebService {
    
    static let instance = WebService()
    typealias completion = (_ status: Alert) -> Void
    private let baseURL = URL.init(string: "e")!
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
            "fullname":fullName,
            "email":email,
            "password":password,
            "osVersion":device.oSVersion,
            "model":device.brand,
            "fcmToken":device.pusheID,
            "id":"1"
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
               // guard let factor = try? decoder.decode(GetCreateFactor.self, from: data) else { completion(false) ; return }
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
}

