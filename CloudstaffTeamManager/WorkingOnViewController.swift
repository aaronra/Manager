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

//    var arrayOfTask = Array<String>()
//    var arrayOfDate = Array<String>()
    
    var arrayOfWorking: [WorkingDetails] = [WorkingDetails]()
    
    var staffID = Int()
    var userSegue = ""
    var passSegue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stf = Staff.objectsWhere("id == \(staffID)")
        for mtrc_stf:RLMObject in stf {
            let mtrixInfo = mtrc_stf as RLMObject
            let mtrix = mtrixInfo["working"] as RLMArray
            for mtxstf:RLMObject in mtrix {
                let mtxInfo = mtxstf as RLMObject
                let task = mtxInfo["task"] as String
                let date = mtxInfo["date"] as String

                var working = WorkingDetails(task: String(task), date: String(date))
            
                arrayOfWorking.append(working)
                
                println("------->>> \(working.date)")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfWorking.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: WorkingOnCell = tableView.dequeueReusableCellWithIdentifier("taskCell") as WorkingOnCell
        
        let working = arrayOfWorking[indexPath.row]
        cell.setCell(working.date, lblTask: working.task)
        
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
