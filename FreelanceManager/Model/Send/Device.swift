//
//  Device.swift
//  FreelanceManager
//
//  Created by Teodik Abrami on 1/19/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import Foundation

struct Device: Codable {
    let name, os, oSVersion, pusheID: String
    let brand: String
    
    enum CodingKeys: String, CodingKey {
        case name, os
        case oSVersion = "oS_Version"
        case pusheID = "pusheId"
        case brand = "brand"
    }
}
