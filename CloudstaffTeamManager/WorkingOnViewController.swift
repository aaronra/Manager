//
//  WorkingOnViewController.swift
//  CloudstaffTeamManager
//
//  Created by RitcheldaV on 10/3/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit
import Realm


class WorkingOnViewController: UIViewController, UITableViewDelegate {
    
//    @IBOutlet weak var tblview: UITableView!
    @IBOutlet weak var tblView: UITableView!

    var arrayofUsername = Array<String>()
    var arrayofName = Array<String>()
    
    var staffID = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStaffList()
    }
    
    func getStaffList() {

        let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        
        let stf = Staff.objectsWhere("id == \(staffID)")
        for mtrc_stf:RLMObject in stf {
            let mtrixInfo = mtrc_stf as RLMObject
            let mtrix = mtrixInfo["working"] as! RLMArray
            for mtxstf:RLMObject in mtrix {
                let mtxInfo = mtxstf as RLMObject
                let task = mtxInfo["task"] as! String
                let date = mtxInfo["date"] as! String
                
                arrayofUsername.append(task)
                arrayofName.append(date)
            }
        }
        realm.commitWriteTransaction()
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayofUsername.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: WorkingOnCell = tableView.dequeueReusableCellWithIdentifier("taskCell") as! WorkingOnCell
        
        cell.lblName.text = arrayofUsername[indexPath.row]
        cell.lblFullName.text = arrayofName[indexPath.row]

        return cell
        
    }

    

    
    


    
    

    
    

    
    
    
}
