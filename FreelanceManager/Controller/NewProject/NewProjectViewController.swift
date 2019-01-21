//
//  NewProjectViewController.swift
//  FreelanceManager
//
//  Created by Teodik Abrami on 1/16/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import UIKit

class NewProjectViewController: UIViewController {
    
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var selectedDateLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        startDatePicker.setValue(UIColor.white, forKeyPath: "textColor")
        endDatePicker.setValue(UIColor.white, forKeyPath: "textColor")
        startDatePicker.calendar = NSCalendar(identifier: NSCalendar.Identifier.persian) as! Calendar
        endDatePicker.calendar = NSCalendar(identifier: NSCalendar.Identifier.persian) as! Calendar
    }
    
    @IBAction func acceptButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "dateToDetail", sender: nil)
    }
    
    @IBAction func startDatePicker(_ sender: UIDatePicker) {
        let dateFormatr = DateFormatter()
        dateFormatr.dateFormat = "dd MMMM"
        dateFormatr.calendar = NSCalendar(identifier: NSCalendar.Identifier.persian) as! Calendar
        let strDate = dateFormatr.string(from: (sender.date))
        selectedDateLabel.text = "تاریخ شروع: " + strDate
    }
    
    @IBAction func endDatePicker(_ sender: UIDatePicker) {
        let dateFormatr = DateFormatter()
        dateFormatr.dateFormat = "dd MMMM"
        dateFormatr.calendar = NSCalendar(identifier: NSCalendar.Identifier.persian) as! Calendar
        let strDate = dateFormatr.string(from: (sender.date))
        selectedDateLabel.text = selectedDateLabel.text ?? "" + "تاریخ اتمام: " + strDate
    }
    

}
