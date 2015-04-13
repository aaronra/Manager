//
//  SettingsTableViewController.swift
//  CloudstaffTeamManager
//
//  Created by RitcheldaV on 10/2/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var autoUpdate: UISwitch!
    @IBOutlet weak var timeInterval: UITextField!
    @IBOutlet weak var defaultMessage: UITextView!
    

    
    ///////////////////////  KEYBOARD DISMISS  /////////////////////////
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        timeInterval.resignFirstResponder()
        defaultMessage.resignFirstResponder()
        self.view.endEditing(true)
    }
    /////////////////////////////////////////////////////////////////////

    
    override func viewDidLoad() {
        super.viewDidLoad()

        timeInterval.delegate = self
        defaultMessage.delegate = self
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 2
    }

    
    @IBAction func done(sender: UIBarButtonItem) {
        performSegueWithIdentifier("bToDashboardDone", sender: self)
        
        println("--->>>> \(defaultMessage.text)")
        
    }
  
    @IBAction func cancel(sender: UIBarButtonItem) {
        performSegueWithIdentifier("bToDashboardCanceled", sender: self)
        println("cancel")
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "bToDashboardDone" {
            let navigationController  = segue.destinationViewController as! UINavigationController
            let myTeamTv = navigationController.topViewController as! DashboardViewController
            

            
        }else if segue.identifier == "bToDashboardCanceled" {
            let navigationController  = segue.destinationViewController as! UINavigationController
            let pingTv = navigationController.topViewController as! DashboardViewController
            

            
        }
    }
    

}
