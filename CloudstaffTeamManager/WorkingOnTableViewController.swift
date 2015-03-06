//
//  WorkingOnTableViewController.swift
//  CloudstaffTeamManager
//
//  Created by RitcheldaV on 6/3/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit

class WorkingOnTableViewController: UITableViewController {

    var arrayOfDate = ["date one", "date two", "date three"]
    var arrayOfTask = ["task one", "task two", "task three"]
    
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
        
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: WorkingOnCell = tableView.dequeueReusableCellWithIdentifier("taskCell") as WorkingOnCell
        
        let selectedView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
        selectedView.backgroundColor = UIColor.whiteColor()
        
        
        
        return cell
        
    }
    
    

}
