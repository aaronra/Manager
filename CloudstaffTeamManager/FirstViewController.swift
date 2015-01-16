//
//  FirstViewController.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 1/11/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        println("First view caontroller")
        

        
    }


    @IBAction func back(sender: AnyObject) {
    
        self.performSegueWithIdentifier("back", sender: self)
        
        println("backed")
    }
}
