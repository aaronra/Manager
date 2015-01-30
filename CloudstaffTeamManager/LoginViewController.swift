//
//  LoginViewController.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 1/13/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
// QWERTY

import UIKit

class LoginViewController: UIViewController {
    
    var Umail = "totep"
    var Pword = "123"
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var forgot: UIButton!
    
    
    ///////////////////////  KEYBOARD DISMISS  /////////////////////////
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    /////////////////////////////////////////////////////////////////////
    

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
        loginfunc()
    
    }

    func loginfunc() {
        
        if username.text == "" && password.text == "" {
            println("null")
            registerNull()
        }else if username.text != Umail && password.text != Pword{
            println("Both Wrong")
            bothWrong()
        }else if username.text != Umail || username.text == ""{
            println("Wrong Email")
            wrongEmail()
        }else if password.text != Pword || password.text == "" {
            println("Wrong Password")
            wrongPassword()
        }else {
            println("Correct")
            self.performSegueWithIdentifier("toPinEntry", sender: self)
        }
        
    }
    
    func registerNull() {
        
        let getname = username.text
        let gettnum = password.text
        
        switch UIDevice.currentDevice().systemVersion.compare("8.0.0", options: NSStringCompareOptions.NumericSearch) {
        case .OrderedSame, .OrderedDescending:
            
            println("8 above")
            
            var alertController = UIAlertController(title: "Cloudstaff Team Manager", message: "Please fill up the required information.", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            })
            
            alertController.addAction(ok)
            presentViewController(alertController, animated: true, completion: nil)
            
        case .OrderedAscending:
            let alertView = UIAlertView(title: "Cloudstaff Team Manager", message: "Please fill up the required information.", delegate: self, cancelButtonTitle: "OK")
            alertView.alertViewStyle = .Default
            alertView.show()
            
            println("8 below")
        }
        
    }
    
    func wrongEmail() {
        let getname = username.text
        let gettnum = password.text
        switch UIDevice.currentDevice().systemVersion.compare("8.0.0", options: NSStringCompareOptions.NumericSearch) {
        case .OrderedSame, .OrderedDescending:
            
            println("8 above")
            
            var alertController = UIAlertController(title: "Cloudstaff Team Manager", message: "Wrong email address.", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            })
            
            alertController.addAction(ok)
            presentViewController(alertController, animated: true, completion: nil)
            
        case .OrderedAscending:
            let alertView = UIAlertView(title: "Cloudstaff Team Manager", message: "Wrong email address.", delegate: self, cancelButtonTitle: "OK")
            alertView.alertViewStyle = .Default
            alertView.show()
            
            println("8 below")
        }
    }
    
    func wrongPassword() {
        let getname = username.text
        let gettnum = password.text
        
        switch UIDevice.currentDevice().systemVersion.compare("8.0.0", options: NSStringCompareOptions.NumericSearch) {
        case .OrderedSame, .OrderedDescending:
            
            println("8 above")
            
            var alertController = UIAlertController(title: "Cloudstaff Team Manager", message: "Wrong password.", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            })
            
            alertController.addAction(ok)
            presentViewController(alertController, animated: true, completion: nil)
            
        case .OrderedAscending:
            let alertView = UIAlertView(title: "Cloudstaff Team Manager", message: "Wrong password.", delegate: self, cancelButtonTitle: "OK")
            alertView.alertViewStyle = .Default
            alertView.show()
            
            println("8 below")
        }
    }
    
    func bothWrong() {
        let getname = username.text
        let gettnum = password.text
        
        switch UIDevice.currentDevice().systemVersion.compare("8.0.0", options: NSStringCompareOptions.NumericSearch) {
        case .OrderedSame, .OrderedDescending:
            
            println("8 above")
            
            var alertController = UIAlertController(title: "Cloudstaff Team Manager", message: "Wrong email and password.", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            })
            
            alertController.addAction(ok)
            presentViewController(alertController, animated: true, completion: nil)
            
        case .OrderedAscending:
            let alertView = UIAlertView(title: "Cloudstaff Team Manager", message: "Wrong email and password.", delegate: self, cancelButtonTitle: "OK")
            alertView.alertViewStyle = .Default
            alertView.show()
            
            println("8 below")
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
