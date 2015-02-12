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
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    

    @IBAction func done(sender: AnyObject) {
        dismissViewControllerAnimated()
        println("done")
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated()
        println("cancel")
    }
    
    func dismissViewControllerAnimated() {
        navigationController?.popViewControllerAnimated(true)
        println("dismiss")
    }
}
