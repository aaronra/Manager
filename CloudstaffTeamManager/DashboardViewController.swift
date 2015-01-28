//
//  DashboardViewController.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 27/1/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, SideBarDelegate, UITableViewDelegate {
    
    let borderWidth = 1.0
    
    @IBOutlet weak var tblView: UITableView!
    var arrayOfEmployees: [Employees] = [Employees]()
    
    
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
        
        self.setUpEmployees()
        
        JSONParser.getContactJSON()
    
        
    }
    
    func setUpEmployees()
    {
        
        var persons = Employees(name: "Anna", number: 20, imageName: "icon_menu.png")
        
        arrayOfEmployees.append(persons)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayOfEmployees.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: CustomCell = tableView.dequeueReusableCellWithIdentifier("Cell") as CustomCell
        let employee = arrayOfEmployees[indexPath.row]
        cell.setCell(employee.name, rightLabelInt: employee.number, imageName: employee.imageName)
        
        return cell
        
    }

    
    func sideBarDidSelectButtonAtIndex(index: Int)
    {
        if index == 0{
            println("first")
//            self.performSegueWithIdentifier("first", sender: self)
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

   
}
