//
//  SettingsTableViewController.swift
//  CloudstaffTeamManager
//
//  Created by RitcheldaV on 10/2/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit


class SettingsTableViewController: UITableViewController, UITextViewDelegate, UITextFieldDelegate {
    
    var alert = AlertDialogs()
    var onBackground = OnBackground()

    @IBOutlet weak var autoUpdate: UISwitch!
    @IBOutlet weak var timeInterval: UITextField!
    @IBOutlet weak var defaultMessage: UITextView!

    let settKey = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeInterval.delegate = self
        defaultMessage.delegate = self
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hideKeyboard")
        view.addGestureRecognizer(tapGesture)
        setAutoUpdateState()

        
    }
    

    func hideKeyboard() {
        timeInterval.resignFirstResponder()
        defaultMessage.resignFirstResponder()
    }
    
    func setAutoUpdateState() {
        let settValue = settKey.stringForKey("isOn")
        let stringArray = settValue!.componentsSeparatedByString(":")
        let interval: String = stringArray [0]
        let defaultM: String = stringArray [1]
        let autoSwitch: String = stringArray [2]
        
        var settValString = NSString(string: autoSwitch)
        timeInterval.text = interval
        defaultMessage.text = defaultM
        autoUpdate!.on = settValString.boolValue
        
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
    
    
    @IBAction func swtUpdate(sender: UISwitch) {
    }

    @IBAction func cancel(sender: UIBarButtonItem) {
        performSegueWithIdentifier("toDashBoardCancel", sender: sender)
    }
    
    
    @IBAction func done(sender: UIBarButtonItem) {
        showAlertForSettings("Save Settings", viewController: self)
    }
    
    
    func showAlertForSettings(title : String, viewController : UITableViewController) -> Void {
        var alertController = UIAlertController(title: title, message: "", preferredStyle: .Alert)
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
            }
        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.settKey.setValue("\(self.timeInterval.text):\(self.defaultMessage.text):\(self.autoUpdate.on.description)", forKey: "isOn")
            
            if self.autoUpdate.on == false {
                self.onBackground.stopUpdate()
                println("FALSE  :  not updating")
            }else {
                self.onBackground.autoUpdate()
                println("TRUE  :  autoUpdate now")
            }
            
//            OnBackground.stopUpdate(self)
            
            println(self.autoUpdate.on.description)
            
            self.performSegueWithIdentifier("toDashBoard", sender: alertController)
        })
        
        
        
        alertController.addAction(cancel)
        alertController.addAction(ok)
        
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
    
    



}
