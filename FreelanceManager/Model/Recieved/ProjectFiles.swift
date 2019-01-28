//
//  GetFiles.swift
//  FreelanceManager
//
//  Created by Teodik Abrami on 1/28/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import Foundation

typealias ProjectFiles = [ProjectFileElement]

struct ProjectFileElement: Codable {
    let id, path, note: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case path, note
    }
}
