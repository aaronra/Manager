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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var forgot: UIButton!

    let myID = UIDevice.currentDevice().identifierForVendor.UUIDString
    let secureID = "manager"
    
    ///////////////////////  KEYBOARD DISMISS  /////////////////////////
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
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
    }

    func loginfunc() {
        
        println("UDID === \(myID)")
        println("secureID == \(secureID.md5)")
        
        JsonToRealm.post(["username":username.text, "password":password.text.md5, "device_key":myID, "secure_key":secureID.md5], url: "http://10.1.51.213/mobile-api/Accounts/login.json") { (loginStatus: String, msg: String) -> () in

            
            println("---->>>>> \(msg)")
            
            if msg == "Username does no exist" {
                self.alert.alertLogin(msg, viewController: self)
            }else if msg == "Incorrect password" {
                self.alert.alertLogin(msg, viewController: self)
                
            }else if msg == "Username or password is blank." {
                self.alert.alertLogin(msg, viewController: self)
            }else {
                self.performSegueWithIdentifier("toDashboard", sender: self.btnLogin)
            }
            
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
            if segue.identifier == "toDashboard" {
            let navigationController  = segue.destinationViewController as UINavigationController
                let dashBTv = navigationController.topViewController as DashboardViewController
            dashBTv.userSegue = username.text
            dashBTv.passSegue = password.text.md5
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
