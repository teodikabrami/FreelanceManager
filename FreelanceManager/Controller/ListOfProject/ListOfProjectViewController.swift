//
//  ListOfProjectViewController.swift
//  FreelanceManager
//
//  Created by Teodik Abrami on 1/16/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import UIKit

class ListOfProjectViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension ListOfProjectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as! myProjectTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "projectToDetail", sender: nil)
    }
    
    
}
