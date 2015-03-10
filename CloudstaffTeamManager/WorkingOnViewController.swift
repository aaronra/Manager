//
//  WorkingOnViewController.swift
//  CloudstaffTeamManager
//
//  Created by RitcheldaV on 10/3/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit
import Realm

class WorkingOnTableViewController: UITableViewController {

    var arrayOfTask = Array<String>()
    var arrayOfDate = Array<String>()
    
    var staffID = Int()
    var userSegue = ""
    var passSegue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("---this>>> \(staffID)")
        
        let stf = Staff.objectsWhere("id == \(staffID)")
        for mtrc_stf:RLMObject in stf {
            let mtrixInfo = mtrc_stf as RLMObject
            let mtrix = mtrixInfo["working"] as RLMArray
            for mtxstf:RLMObject in mtrix {
                let mtxInfo = mtxstf as RLMObject
                let task  =  mtxInfo["task"]  as  String
                let date  =  mtxInfo["date"]  as  String

                arrayOfTask.append(task)
                arrayOfDate.append(date)

            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfTask.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: WorkingOnCell = tableView.dequeueReusableCellWithIdentifier("taskCell") as WorkingOnCell
        
        cell.lblDateTime.text = arrayOfTask[indexPath.row]
        cell.lblTask.text = arrayOfDate[indexPath.row]
        
        return cell
        
    }
    
    @IBAction func back(sender: AnyObject) {
        performSegueWithIdentifier("toMyTeam", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       if segue.identifier == "toMyTeam" {
            let navigationController  = segue.destinationViewController as UINavigationController
            let toMyTeamTV = navigationController.topViewController as MyTeamViewController
            toMyTeamTV.userSegue = userSegue
            toMyTeamTV.passSegue = passSegue
        }
    }
    
}
