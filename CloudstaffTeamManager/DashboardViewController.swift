//
//  DashboardViewController.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 27/1/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, SideBarDelegate, UITableViewDelegate, UICollectionViewDelegate {
    
    let borderWidth = 1.0       
    
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var colletionView: UICollectionView!
    var arrayOfMetrics: [Metrics] = [Metrics]()
    
    var arrayofStaffs: [String] = ["staff","staff","staff","staff","staff","staff","staff"]
    var arrayofStatus: [String] = ["online","offline","online","online","online","online","online"]
    
    var sideBar:SideBar = SideBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideBar = SideBar(sourceView: self.view, menuItems:
            ["dashboard",
                "my team",
                "ping",
                "settings",
                "log out"])
        sideBar.delegate = self
        
        self.populateMetrics()
        
    }
    
    func populateMetrics()
    {
        var i = 0
        var d = 0
        var w = 0
        var v = 0
        
        while (i != 15)
        {
            ++d
            ++w
            ++v
            ++i
            
            var metrics = Metrics(title:"Sample Title " + String(i), lbldaily:"daily average", lblweekly:"weekly average", daily: d, weekly: w, value: v)
            
            arrayOfMetrics.append(metrics)
        }
        
//        var metrics1  = Metrics(title:"Sales Responses", lbldaily:"daily average", lblweekly:"weekly average", daily: 23, weekly: 135, value: 275)
//        
//        var metrics2  = Metrics(title:"Open Tickets", lbldaily:"daily average", lblweekly:"weekly average", daily: 23, weekly: 56, value: 85)
//        
//        arrayOfMetrics.append(metrics1)
//        arrayOfMetrics.append(metrics2)
        
       
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayOfMetrics.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: DashboardCell = tableView.dequeueReusableCellWithIdentifier("Cell") as DashboardCell
        
        if indexPath.row % 2 == 0
        {
            cell.backgroundColor = UIColor(hex: 0xDDDDDD)
        }else{
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        let metrics = arrayOfMetrics[indexPath.row]
        
        cell.setCell(metrics.title, lbldaily: metrics.lbldaily, lblweekly: metrics.lblweekly, daily: metrics.daily, weekly: metrics.weekly, value: metrics.value)
        
        println(metrics.value)
        
        return cell
        
    }

    
    func sideBarDidSelectButtonAtIndex(index: Int)
    {
        if index == 0{
            println("first")
            sideBar.showSideBar(false)
            //self.performSegueWithIdentifier("toDashboard", sender: self)
        } else if index == 1 {
            println("second")
        } else if index == 3{
            println("third")
        }
    }
    
    
    @IBAction func showMenu(sender: AnyObject) {
        
        if sideBar.isSideBarOpen == true {
            sideBar.showSideBar(false)
        }else{
            sideBar.showSideBar(true)
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayofStaffs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: StaffCell = collectionView.dequeueReusableCellWithReuseIdentifier("staffCell", forIndexPath: indexPath) as StaffCell
        
        cell.statusCell.image = UIImage(named: arrayofStatus[indexPath.row])
        cell.imgCell.image = UIImage(named: arrayofStaffs[indexPath.row])
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("Cell \(indexPath.row) selected")
    }


}
