//
//  LoginViewController.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 1/13/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var Umail = "totep"
    var Pword = "123"
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var btnLogin: UIButton!

    
    let ipad = UIDevice.currentDevice().userInterfaceIdiom == .Pad
    let iphone = UIDevice.currentDevice().userInterfaceIdiom == .Phone
    let unknown = UIDevice.currentDevice().userInterfaceIdiom == .Unspecified
    
    
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
    }
    
    @IBAction func login(sender: AnyObject) {
        
        loginfunc()
        
        var login = Login()
        login.EmailfromLogin = email.text
        login.PwordfromLogin = password.text
        println("\(login.EmailfromLogin) + \(login.PwordfromLogin)")
        
        
    }


    func loginfunc() {
        
        if email.text == "" && password.text == "" {
            println("null")
            registerNull()
        }else if email.text != Umail && password.text != Pword{
            println("Both Wrong")

        }else if email.text != Umail || email.text == ""{
            println("Wrong Email")
            wrongEmail()
        }else if password.text != Pword || password.text == "" {
            println("Wrong Password")
            wrongPassword()
        }else {
            println("Correct")
            self.performSegueWithIdentifier("toDashBoard", sender: self)
        }
        
    }
    
    func registerNull() {
        let getname = email.text
        let gettnum = password.text
        var alertController = UIAlertController(title: "Cloudstaff Team Manager", message: "Please fill up the required information.", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
        })
        
        alertController.addAction(ok)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func wrongEmail() {
        let getname = email.text
        let gettnum = password.text
        var alertController = UIAlertController(title: "Cloudstaff Team Manager", message: "Wrong email address.", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
        })
        alertController.addAction(ok)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func wrongPassword() {
        let getname = email.text
        let gettnum = password.text
        var alertController = UIAlertController(title: "Cloudstaff Team Manager", message: "Wrong password.", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
        })
        alertController.addAction(ok)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func bothWrong() {
        let getname = email.text
        let gettnum = password.text
        var alertController = UIAlertController(title: "Cloudstaff Team Manager", message: "Wrong email and password.", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
        })
        alertController.addAction(ok)
        presentViewController(alertController, animated: true, completion: nil)
    }
    

    
    func device() {
        if ipad.boolValue {
            println("im on ipad")
            login(btnLogin)
        }else if iphone.boolValue {
            println("im on iphone")
        }else {
            println("unknown")
        }
    }
}
