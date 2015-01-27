//
//  DashboardViewController.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 27/1/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
<<<<<<< HEAD
// asasasasas
=======
//  
>>>>>>> CSTM_branch

import UIKit

class DashboardViewController: UIViewController, SideBarDelegate {
    
    let borderWidth = 1.0
    
    
    @IBOutlet weak var mtextField: UITextField!
    
    
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
        
    }
    
    
    
    func sideBarDidSelectButtonAtIndex(index: Int) {
        if index == 0{
            
            println("first")
//            self.performSegueWithIdentifier("first", sender: self)
            
            
        } else if index == 1{
            
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
