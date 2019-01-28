//
//  Contacts.swift
//  FreelanceManager
//
//  Created by Teodik Abrami on 1/28/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import Foundation
typealias ProjectContacts = [ProjectContactElement]

struct ProjectContactElement: Codable {
    let id, name, tel, role: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, tel, role
    }
}
