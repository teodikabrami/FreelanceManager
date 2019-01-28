//
//  Payments.swift
//  FreelanceManager
//
//  Created by Teodik Abrami on 1/28/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import Foundation

typealias ProjectPayments = [ProjectPayment]

struct ProjectPayment: Codable {
    let date, amount, note: String
}
