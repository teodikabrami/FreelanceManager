//
//  ProjectList.swift
//  FreelanceManager
//
//  Created by Teodik Abrami on 1/28/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import Foundation

typealias ProjectList = [ProjectListElement]

struct ProjectListElement: Codable {
    let files: [String]
    let contacts: [Contact]
    let payments: [Payment]
    let id, name, cDate, eDate: String
    let price, comment, projStatus: String
    
    enum CodingKeys: String, CodingKey {
        case files, contacts, payments
        case id = "_id"
        case name, cDate, eDate, price, comment, projStatus
    }
}

struct Contact: Codable {
    let id, name, tel, role: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, tel, role
    }
}

struct Payment: Codable {
    let id, date, amount, note: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case date, amount, note
    }
}
