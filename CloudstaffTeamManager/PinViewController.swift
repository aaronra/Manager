//
//  PinViewController.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 21/1/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit

class PinViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtPin1: UITextField!
    @IBOutlet weak var txtPin2: UITextField!
    @IBOutlet weak var txtPin3: UITextField!
    @IBOutlet weak var txtPin4: UITextField!
    @IBOutlet weak var forgotPin: UIButton!

    
    var txtPIN = ""
    
    let notificationCenter = NSNotificationCenter.defaultCenter()
    let yourPIN = "1234"
    
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
        
        txtPin1.becomeFirstResponder()
        txtPin1.delegate = self
        txtPin2.delegate = self
        txtPin3.delegate = self
        txtPin4.delegate = self
        
        notificationCenter.addObserver(self, selector: "textFieldTextChanged:", name: UITextFieldTextDidChangeNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    
    func textFieldTextChanged(sender : AnyObject) {
        if self.txtPin1.hasText() {
            self.txtPIN = self.txtPin1.text
            txtPin1.resignFirstResponder()
            txtPin2.becomeFirstResponder()
        }
        
        if self.txtPin2.hasText() {
            self.txtPIN = self.txtPIN + self.txtPin2.text
            txtPin2.resignFirstResponder()
            txtPin3.becomeFirstResponder()
        }
        
        if self.txtPin3.hasText() {
            self.txtPIN = self.txtPIN + self.txtPin3.text
            txtPin3.resignFirstResponder()
            txtPin4.becomeFirstResponder()
        }
        
        if self.txtPin4.hasText() {
            self.txtPIN = self.txtPIN + self.txtPin4.text
            txtPin4.resignFirstResponder()
            println(self.txtPIN)
            
            if txtPIN == yourPIN {
                
                if ConnectionDetector.isConnectedToNetwork() == true {
                    println("TRUE")
//                    JsonToRealm.parseData()
                } else {
                    println("NO CONNECTION")
                }
                
                self.performSegueWithIdentifier("toDashboard", sender: self)
            } else {
                println("FALSE")
                self.txtPin1.text = ""
                self.txtPin2.text = ""
                self.txtPin3.text = ""
                self.txtPin4.text = ""
                self.txtPin1.becomeFirstResponder()
                
                switch UIDevice.currentDevice().systemVersion.compare("8.0.0", options: NSStringCompareOptions.NumericSearch) {
                case .OrderedSame, .OrderedDescending:
                    
                    println("8 above")
                    
                    var alertController = UIAlertController(title: "Cloudstaff Team Manager", message: "Wrong PIN", preferredStyle: .Alert)
                    let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    })
                    
                    alertController.addAction(ok)
                    presentViewController(alertController, animated: true, completion: nil)
                    
                case .OrderedAscending:
                    let alertView = UIAlertView(title: "Cloudstaff Team Manager", message: "Wrong PIN", delegate: self, cancelButtonTitle: "OK")
                    alertView.alertViewStyle = .Default
                    alertView.show()
                    
                    println("8 below")
                }
                
            }
        }

    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.registerForKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.deregisterFromKeyboardNotifications()
        super.viewWillDisappear(true)
        
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
        var buttonOrigin: CGPoint = self.forgotPin.frame.origin;
        var buttonHeight: CGFloat = self.forgotPin.frame.size.height;
        var visibleRect: CGRect = self.view.frame
        visibleRect.size.height -= keyboardSize.height
        
        if (!CGRectContainsPoint(visibleRect, buttonOrigin)) {
            var scrollPoint: CGPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight + 4)
            self.scrollView.setContentOffset(scrollPoint, animated: true)
            
        }
    }
    
    func hideKeyboard() {
        txtPin1.resignFirstResponder()   //FirstResponder's must be resigned for hiding keyboard.
        txtPin2.resignFirstResponder()
        txtPin3.resignFirstResponder()
        txtPin4.resignFirstResponder()

        self.scrollView.setContentOffset(CGPointZero, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    }
