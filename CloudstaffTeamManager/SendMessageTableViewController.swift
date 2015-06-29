//
//  SendMessageTableViewController.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 3/5/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit

class SendMessageTableViewController: UITableViewController {
    
    var staffID = Int()
    var alert = AlertDialogs()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        performSegueWithIdentifier("toMyTeam", sender: self)
    }
    
    @IBAction func send(sender: UIBarButtonItem) {
        showMessageAlertView("Cloudstaf Team Manager", message: "Send Message", viewController: self)
    }
    
    
    func showMessageAlertView(title: String, message: String, viewController: UIViewController) {
        var alert = UIAlertView()
        alert.delegate = self
        alert.title = title
        alert.message = message
        alert.alertViewStyle = .Default
        alert.addButtonWithTitle("OK")
        alert.addButtonWithTitle("Cancel")
        alert.show()
    }
    internal func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 0:
            self.performSegueWithIdentifier("toMyTeam", sender: alertView)
            break;
        case 1:
            println("CANCEL \(buttonIndex)")
            break;
        default: ()
        println("DEFAULT \(buttonIndex)")
        }
    }
    

    
    
}

