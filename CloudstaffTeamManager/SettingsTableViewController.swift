//
//  SettingsTableViewController.swift
//  CloudstaffTeamManager
//
//  Created by RitcheldaV on 5/2/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit
import Darwin

class SettingsTableViewController: UITableViewController, SideBarDelegate {

    @IBOutlet weak var autoUpdate: UISwitch!
    @IBOutlet weak var defaultMessage: UITextView!
    
    var sideBar:SideBar = SideBar()
    
    ///////////////////////  KEYBOARD DISMISS  /////////////////////////
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    /////////////////////////////////////////////////////////////////////
    
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
    
    func sideBarDidSelectButtonAtIndex(index: Int)
    {
        if index == 0{
            self.performSegueWithIdentifier("toDashboard", sender: self)
        } else if index == 1 {
        } else if index == 2 {
        } else if index == 3 {
            sideBar.showSideBar(false)
        } else if index == 4 {
            exit(0)
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
