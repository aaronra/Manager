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
    var userSegue = ""
    var passSegue = ""
    
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
        var alertController = UIAlertController(title: "Cloudstaff Team Manager", message: "Send Message", preferredStyle: .Alert)
        
        
        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.performSegueWithIdentifier("toMyTeam", sender: alertController)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in}
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toMyTeam" {
            
            let navigationController  = segue.destinationViewController as UINavigationController
            let myTeamVC = navigationController.topViewController as MyTeamViewController
            myTeamVC.userSegue = userSegue
            myTeamVC.passSegue = passSegue
            
        }
        
    }
    
    
    
    
}

