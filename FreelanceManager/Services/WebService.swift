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
    private let baseURL = URL.init(string: "http://budgetapplication.dlinkddns.com:3031/")!
    private let head = ["Authorization":"Bearer" + " " + Authorization.shared.token,
                        "application/json":"application/json"
    ]
    private var device: Device {
        return Device.init(name: "Iphone", os: "ios", oSVersion: getOSInfo(), pusheID: "fcmtoken", brand: UIDevice.modelName)
    }
    
    public func register(email: String, fullName: String, password: String, completion: @escaping completion) {
        print("register")
        let url = baseURL.appendingPathComponent("register")
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
       // request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let parameters = [
            "fullName":"test111",
            "email":"test111",
            "password":"test111",
            "osVersion":device.oSVersion,
          //  "devModel":device.brand,
            "fcmToken":device.pusheID,
            "platformID":"1"
        ]
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(.failed)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
                guard let register = try? decoder.decode(Register.self, from: data) else { completion(.failed) ; return }
                Authorization.shared.authenticationUser(token: register.token, isLoggedIn: true)
                completion(.success)
            } else {
                completion(.failed)
            }
        }
        task.resume()
    }
    
    public func login(email: String, password: String, completion: @escaping completion) {
        let url = baseURL.appendingPathComponent("login")
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let parameters = [
            "email":"test111",
            "password":"test111"
        ]
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(.failed)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
                guard let register = try? decoder.decode(Register.self, from: data) else { completion(.failed) ; return }
                Authorization.shared.authenticationUser(token: register.token, isLoggedIn: true)
                self.decodeJWT(token: register.token)
                completion(.success)
            } else {
                completion(.failed)
            }
        }
        task.resume()
        
        
    }
    
    
    public func getSalary(completion: @escaping (_ salary: Salary?) -> Void)  {
        let url = baseURL.appendingPathComponent("salary")
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = head
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
                guard let decodedJson = try? decoder.decode(Salary.self, from: data) else { completion(nil) ; return }
                completion(decodedJson)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    
    public func newProject(name: String, cdate: String, edate: String, price: String, comment: String, downPrice:String, owner: String, tel: String, completion: @escaping (_ status: Bool) -> Void)  {
        let url = baseURL.appendingPathComponent("projects/new")
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let parameters = [
            "name":name,
            "cdate":cdate,
            "edate":edate,
            "price":price,
            "comment":comment,
            "downPrice":downPrice,
            "owner":owner,
            "tel": tel
        ]
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        request.allHTTPHeaderFields = head
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(false)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
                guard let decodedJson = try? decoder.decode(NewProject.self, from: data) else { completion(false) ; return }
                decodedJson.status ? completion(true) : completion(false)
            } else {
                completion(false)
            }
        }
        task.resume()
    }
    
    
    public func updateProject(projectID: String, name: String, cdate: String, edate: String, price: String, comment: String, downPrice:String, owner: String, tel: String, completion: @escaping (_ status: Bool) -> Void)  {
        let url = baseURL.appendingPathComponent("projects/\(projectID)")
        var request = URLRequest.init(url: url)
        request.httpMethod = "PUT"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let parameters = [
            "name":name,
            "cdate":cdate,
            "edate":edate,
            "price":price,
            "comment":comment,
            "downPrice":downPrice,
            "owner":owner,
            "tel": tel
        ]
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        request.allHTTPHeaderFields = head
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(false)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
                guard let decodedJson = try? decoder.decode(NewProject.self, from: data) else { completion(false) ; return }
                decodedJson.status ? completion(true) : completion(false)
            } else {
                completion(false)
            }
        }
        task.resume()
    }

    
    public func updateStatusOfProject(projectID: String, status: ProjectStatus , completion: @escaping (_ status: Bool) -> Void)  {
        let url = baseURL.appendingPathComponent("projects/\(projectID)/statusUpdate")
        var request = URLRequest.init(url: url)
        request.httpMethod = "PUT"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let parameters = [
            "projStatus":status.rawValue
        ]
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        request.allHTTPHeaderFields = head
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(false)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
                guard let decodedJson = try? decoder.decode(NewProject.self, from: data) else { completion(false) ; return }
                decodedJson.status ? completion(true) : completion(false)
            } else {
                completion(false)
            }
        }
        task.resume()
    }
    
    
    public func getAllProjects(completion: @escaping (_ projects: ProjectList?) -> Void)  {
        let url = baseURL.appendingPathComponent("projects")
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = head
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
                guard let decodedJson = try? decoder.decode(ProjectList.self, from: data) else { completion(nil) ; return }
                completion(decodedJson)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    
    public func newPayment(projectID: String, date: String, note: String, amount: String , completion: @escaping (_ status: Bool) -> Void)  {
        let url = baseURL.appendingPathComponent("projects/\(projectID)/payments/new")
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let parameters = [
            "date":date,
            "note":note,
            "amount":amount
        ]
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        request.allHTTPHeaderFields = head
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(false)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
                guard let decodedJson = try? decoder.decode(NewProject.self, from: data) else { completion(false) ; return }
                decodedJson.status ? completion(true) : completion(false)
            } else {
                completion(false)
            }
        }
        task.resume()
    }
    
    public func updatePayment(projectID: String, paymentId: String, date: String, note: String, amount: String , completion: @escaping (_ status: Bool) -> Void)  {
        let url = baseURL.appendingPathComponent("projects/\(projectID)/payments/\(paymentId)")
        var request = URLRequest.init(url: url)
        request.httpMethod = "PUT"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let parameters = [
            "date":date,
            "note":note,
            "amount":amount
        ]
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        request.allHTTPHeaderFields = head
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(false)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
                guard let decodedJson = try? decoder.decode(NewProject.self, from: data) else { completion(false) ; return }
                decodedJson.status ? completion(true) : completion(false)
            } else {
                completion(false)
            }
        }
        task.resume()
    }
    
    
    public func getProjectPayment(projectID: String, completion: @escaping (_ payments: ProjectPayments?) -> Void)  {
        let url = baseURL.appendingPathComponent("projects/\(projectID)/payments/")
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = head
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
                guard let decodedJson = try? decoder.decode(ProjectPayments.self, from: data) else { completion(nil) ; return }
            completion(decodedJson)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    public func deleteProjectPayment(projectID: String, paymentID: String ,completion: @escaping (_ status: Bool) -> Void)  {
        let url = baseURL.appendingPathComponent("projects/\(projectID)/payments/\(paymentID)")
        var request = URLRequest.init(url: url)
        request.httpMethod = "DELETE"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = head
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(false)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
                guard let decodedJson = try? decoder.decode(NewProject.self, from: data) else { completion(false) ; return }
                decodedJson.status ? completion(true) : completion(false)
            } else {
                completion(false)
            }
        }
        task.resume()
    }
    
    
    public func newContact(projectID: String, name: String, tel: String, role: String ,completion: @escaping (_ status: Bool) -> Void)  {
        let url = baseURL.appendingPathComponent("projects/\(projectID)/contacts/new")
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let parameters = [
            "name":name,
            "tel":tel,
            "role":role
        ]
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        request.allHTTPHeaderFields = head
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(false)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
                guard let decodedJson = try? decoder.decode(NewProject.self, from: data) else { completion(false) ; return }
                decodedJson.status ? completion(true) : completion(false)
            } else {
                completion(false)
            }
        }
        task.resume()
    }
    
    
    public func updateContact(projectID: String, contactID: String, name: String, tel: String, role: String ,completion: @escaping (_ status: Bool) -> Void)  {
        let url = baseURL.appendingPathComponent("projects/\(projectID)/contacts/\(contactID)")
        var request = URLRequest.init(url: url)
        request.httpMethod = "PUT"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let parameters = [
            "name":name,
            "tel":tel,
            "role":role
        ]
        request.httpBody = Data.createDataBody(withParameters: parameters, boundary: boundary)
        request.allHTTPHeaderFields = head
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(false)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
                guard let decodedJson = try? decoder.decode(NewProject.self, from: data) else { completion(false) ; return }
                decodedJson.status ? completion(true) : completion(false)
            } else {
                completion(false)
            }
        }
        task.resume()
    }
    
    
    public func getProjectContacts(projectID: String, completion: @escaping (_ contact: ProjectContacts?) -> Void)  {
        let url = baseURL.appendingPathComponent("projects/\(projectID)/contacts/")
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = head
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
                guard let decodedJson = try? decoder.decode(ProjectContacts.self, from: data) else { completion(nil) ; return }
                completion(decodedJson)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    
    public func deleteProjectContact(projectID: String, contactId: String ,completion: @escaping (_ status: Bool) -> Void)  {
        let url = baseURL.appendingPathComponent("projects/\(projectID)/contacts/\(contactId)")
        var request = URLRequest.init(url: url)
        request.httpMethod = "DELETE"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = head
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(false)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
                guard let decodedJson = try? decoder.decode(NewProject.self, from: data) else { completion(false) ; return }
                decodedJson.status ? completion(true) : completion(false)
            } else {
                completion(false)
            }
        }
        task.resume()
    }
    
    
    
    func postMultipartFormDataRequest(projectID: String, note: String, photo: Data?, completion: @escaping (_ status: Bool) -> Void) {
        let url = baseURL.appendingPathComponent("/projects/\(projectID)/files/new")
        let parameter = ["note":note]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = generateBoundary()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let dataBody = createDataBody(withParameters: parameter, media: photo, boundary: boundary)
        request.httpBody = dataBody
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(false)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
                guard let decodedJson = try? decoder.decode(NewProject.self, from: data) else { completion(false) ; return }
                decodedJson.status ? completion(true) : completion(false)
            } else {
                completion(false)
            }
        }
        task.resume()
    }
    
    public func getProjectFiles(projectID: String, completion: @escaping (_ contact: ProjectFiles?) -> Void)  {
        let url = baseURL.appendingPathComponent("projects/\(projectID)/files/")
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = head
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(nil)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
                guard let decodedJson = try? decoder.decode(ProjectFiles.self, from: data) else { completion(nil) ; return }
                completion(decodedJson)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    public func deleteProjectFiles(projectID: String, fileID: String ,completion: @escaping (_ status: Bool) -> Void)  {
        let url = baseURL.appendingPathComponent("projects/\(projectID)/files/\(fileID)")
        var request = URLRequest.init(url: url)
        request.httpMethod = "DELETE"
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = head
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(false)
                return
            }
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
                guard let decodedJson = try? decoder.decode(NewProject.self, from: data) else { completion(false) ; return }
                decodedJson.status ? completion(true) : completion(false)
            } else {
                completion(false)
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

        print(userId)
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

