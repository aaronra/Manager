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
//        if ConnectionDetector.isConnectedToNetwork() {
            loginfunc()
//        }else {
//           alert.alertLogin("No Internet Connection", viewController: self)
//        }
    
        
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
        
        let urlAsString = "http://localhost:619/cakephp/Accounts/login/\(username.text)/\(password.text.md5).json"
        let url: NSURL  = NSURL(string: urlAsString)!
        let urlSession = NSURLSession.sharedSession()
        
        let jsonQuery = urlSession.dataTaskWithURL(url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                println(error.localizedDescription)
            }
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as! NSDictionary
            if (err != nil) {
                println("JSON Error \(err!.localizedDescription)")
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                let loginStatus = jsonResult["LoginStatus"] as! String
                
                if loginStatus == "Success" {
                    JsonToRealm.parseData("\(self.username.text)/\(self.password.text.md5)")
                    var time = dispatch_time(DISPATCH_TIME_NOW, 1 * Int64(NSEC_PER_SEC))
                    dispatch_after(time, dispatch_get_main_queue()) {
                        self.performSegueWithIdentifier("toDashboard", sender: self.btnLogin)
                    }

                }else if loginStatus == "Wrong Password"{
                    self.alert.alertLogin(loginStatus, viewController: self)
                    println("LoginStatus --->>> \(loginStatus)")
                }else {
                    self.alert.alertLogin(loginStatus, viewController: self)
                    println("LoginStatus --->>> \(loginStatus)")
                }
            })
        })
        jsonQuery.resume()
        
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
