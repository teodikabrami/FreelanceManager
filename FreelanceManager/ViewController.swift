//
//  ViewController.swift
//  FreelanceManager
//
//  Created by Teodik Abrami on 1/15/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        WebService.instance.register(email: "", fullName: "", password: "") { (_) in
            //
        }
    }


}

