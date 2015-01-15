//
//  ViewController.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 1/9/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit


class ViewController: UIViewController, SideBarDelegate {
    
    let borderWidth = 1.0
    
   
    
    @IBOutlet weak var mtextField: UITextField!
    @IBOutlet weak var bton: UIButton!
    
    var sideBar:SideBar = SideBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideBar = SideBar(sourceView: self.view, menuItems:
           ["notifications",
            "home",
            "dahsboard",
            "my team",
            "my favourites",
            "recent contacts",
            "settings",
            "sign out"])
        sideBar.delegate = self
        
        bton.layer.cornerRadius = 8.0

        
    }
    

    
    func sideBarDidSelectButtonAtIndex(index: Int) {
        if index == 0{
            
            println("first")
            self.performSegueWithIdentifier("first", sender: self)

  
        } else if index == 1{
            
            println("second")

        } else if index == 3{
            
            println("third")
        }
    }
    
    
    @IBAction func menu(sender: AnyObject) {
        if sideBar.isSideBarOpen == true {
            sideBar.showSideBar(false)
        }else {
            sideBar.showSideBar(true)
        }
    }
    
    

    
}

