//
//  SendMessageTableViewController.swift
//  CloudstaffTeamManager
//
//  Created by RitcheldaV on 4/3/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit

class SendMessageTableViewController: UITableViewController {
    
    var staffID = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
        performSegueWithIdentifier("toMyTeam", sender: self)
    }
    
    
}
