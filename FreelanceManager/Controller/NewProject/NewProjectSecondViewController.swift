//
//  NewProjectSecondViewController.swift
//  FreelanceManager
//
//  Created by Teodik Abrami on 1/16/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import UIKit

class NewProjectSecondViewController: UIViewController {

    @IBOutlet weak var projectStartLabel: UILabel!
    @IBOutlet weak var projectEndLabel: UILabel!
    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var ownerNameTextLabel: UITextField!
    @IBOutlet weak var ownerNumberTextField: UITextField!
    @IBOutlet weak var totalProjectPriceTextField: UITextField!
    @IBOutlet weak var downPercentPaidTextField: UITextField!
    @IBOutlet weak var downPricePaidTextField: UITextField!
    @IBOutlet weak var remainPayingLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
    }
    
}
