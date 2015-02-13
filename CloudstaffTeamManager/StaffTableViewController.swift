//
//  StaffTableViewController.swift
//  CloudstaffTeamManager
//
//  Created by RitcheldaV on 13/2/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit

class StaffTableViewController: UITableViewController {

    @IBOutlet weak var imgStaff: UIImageView!
    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var detailOne: UILabel!
    @IBOutlet weak var detailTwo: UILabel!
    @IBOutlet weak var detailThree: UILabel!
    @IBOutlet weak var detailFour: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        
        return cell
        
     }

}
