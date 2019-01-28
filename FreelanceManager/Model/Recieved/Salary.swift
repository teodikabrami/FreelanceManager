//
//  Salary.swift
//  FreelanceManager
//
//  Created by Teodik Abrami on 1/28/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import Foundation

struct Salary: Codable {
    let salary: [String: Int]
    let thisMonthSalary, thisYearSalary, averageYearSalary, remainingSalary: Int
}
