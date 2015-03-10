//
//  WorkingOnViewController.swift
//  CloudstaffTeamManager
//
//  Created by RitcheldaV on 10/3/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit

class WorkingOnViewController: UIViewController {

    var arrayOfTask = ["one", "two", "three"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfTask.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: WorkingOnCell = tableView.dequeueReusableCellWithIdentifier("taskCell") as WorkingOnCell
        
        cell.lblDateTime.text = arrayOfTask[indexPath.row]
        cell.lblTask.text = arrayOfTask[indexPath.row]
        
        return cell
        
    }
    
    @IBAction func back(sender: AnyObject) {
        performSegueWithIdentifier("toMyTeam", sender: self)
    }
}
