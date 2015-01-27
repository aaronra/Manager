//
//  PinViewController.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 21/1/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit

class PinViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtPin1: UITextField!
    @IBOutlet weak var txtPin2: UITextField!
    @IBOutlet weak var txtPin3: UITextField!
    @IBOutlet weak var txtPin4: UITextField!

    
    var txtPIN = ""
    
    let notificationCenter = NSNotificationCenter.defaultCenter()
    let yourPIN = "1234"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                println("TRUE")
                self.performSegueWithIdentifier("toDashboard", sender: self)
            } else {
                println("FALSE")
                self.txtPin1.text = ""
                self.txtPin2.text = ""
                self.txtPin3.text = ""
                self.txtPin4.text = ""
                self.txtPin1.becomeFirstResponder()
                
                var alertController = UIAlertController(title: "Cloudstaff Team Manager", message: "Wrong PIN", preferredStyle: .Alert)
                let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                })
                alertController.addAction(ok)
                presentViewController(alertController, animated: true, completion: nil)
                
            }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    }
