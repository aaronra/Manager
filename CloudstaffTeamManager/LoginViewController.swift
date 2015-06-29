//
//  LoginViewController.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 1/13/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
// QWERTYqqgit

import UIKit

class LoginViewController: UIViewController {
    

    var json = JsonToRealm()
    var alert = AlertDialogs()
    let prefKey = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var forgot: UIButton!
    

    let secureID = "manager"
    let deviceName = UIDevice.currentDevice().name
    let deviceID = UIDevice.currentDevice().identifierForVendor.UUIDString
    var salt = "5d534e77a8c480d924bb75dd46a216bc08a587a7"
    
    
    ///////////////////////  KEYBOARD DISMISS  /////////////////////////
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)

    }
    ////////////////////////////////////////////////////////////////////
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hideKeyboard")
        // prevents the scroll view from swallowing up the touch event of child buttons
        tapGesture.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tapGesture)
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.deregisterFromKeyboardNotifications()
        super.viewWillDisappear(true)
        
    }

    @IBAction func login(sender: AnyObject) {
        if ConnectionDetector.isConnectedToNetwork() {
            loginfunc()
        }else {
           alert.alertLogin("No Internet Connection", viewController: self)
        }
    
        if let prefValue = prefKey.stringForKey("holdingData") {
            println("INSTALLED: " + prefValue)
            if prefValue != "\(username.text):\(password.text.md5)" {
                prefKey.setValue("\(username.text):\(password.text.md5)", forKey: "holdingData")
                println("VALUE CHANGED")
            }
        }else {
            prefKey.setValue("\(username.text):\(password.text.md5)", forKey: "holdingData")
            println("INSTALLED: " + prefKey.description)
        }

    }
 
    func loginfunc() {
        JsonToRealm.postLogin(["username":username.text,
                          "password":(salt+password.text).sha1(),
                          "secureID":secureID.md5,
                          "devicename": deviceName,
                          "deviceID": deviceID],
            url: "http://10.1.100.69:90/clients/login.json") { (code: Int, msg: String, sessionID: String, clientID: String) -> () in
            
//                println("--->>>> \(self.username.text)")
//                println("--->>>> \((self.salt+self.password.text).sha1())")
//                println("--->>>> \(self.secureID.md5)")
//                println("--->>>> \(self.deviceName)")
//                println("--->>>> \(self.deviceID)")
                
            if code == 500 {
                println(msg)
                self.alert.alertLogin(msg, viewController: self)
            } else if code == 200 {
                if msg == "You are currently logged in from your iPhone Simulator. Logging in on this device will log you out from your other device. Would you like to proceed?" {
                    self.alert.overWrite(msg, viewController: self)
                }else {
                    JsonToRealm.fetchData(["clientID": clientID,
                                           "sessionID": sessionID,
                                           "deviceID": self.deviceName,
                                           "secureID": self.deviceID],
                        url: "http://10.1.100.100:90/clients/getEmployees.json")
                    var time = dispatch_time(DISPATCH_TIME_NOW, 1 * Int64(NSEC_PER_SEC))
                    dispatch_after(time, dispatch_get_main_queue()) {
                        self.performSegueWithIdentifier("toDashboard", sender: self.btnLogin)
                    }
                    println("Successful")
                }
            }else {
                println("ERROR")
            }
        }
    }
    
    
    func registerForKeyboardNotifications() -> Void {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func deregisterFromKeyboardNotifications() -> Void {
        println("Deregistering!")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification) {
        var info: Dictionary = notification.userInfo!
        var keyboardSize: CGSize = (info[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue().size)!
        var buttonOrigin: CGPoint = self.forgot.frame.origin;
        var buttonHeight: CGFloat = self.forgot.frame.size.height;
        var visibleRect: CGRect = self.view.frame
        visibleRect.size.height -= keyboardSize.height
        
        if (!CGRectContainsPoint(visibleRect, buttonOrigin)) {
            var scrollPoint: CGPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight + 4)
            self.scrollView.setContentOffset(scrollPoint, animated: true)
        }
    }
    
    func hideKeyboard() {
        username.resignFirstResponder()   //FirstResponder's must be resigned for hiding keyboard.
        password.resignFirstResponder()
        self.scrollView.setContentOffset(CGPointZero, animated: true)
    }
}
