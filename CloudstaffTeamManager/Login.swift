//
//  Login.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 1/15/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit

public class Login: NSObject {
    
    var EmailfromLogin = ""
    var PwordfromLogin = ""
    var statEmail = "totep"
    var statPword = "123"
    
    
    func loginfunc() {
        
        if EmailfromLogin == "" && PwordfromLogin == "" {
            println("null")
//            registerNull()
        }else if EmailfromLogin != statEmail && PwordfromLogin != statPword {
            println("Both Wrong")
            
        }else if EmailfromLogin != statEmail || EmailfromLogin == ""{
            println("Wrong Email")
//            wrongEmail()
        }else if PwordfromLogin != statPword || PwordfromLogin == "" {
            println("Wrong Password")
//            wrongPassword()
        }else {
            println("Correct")
            
        }
        
    }
    
    
//    func registerNull() {
//        let getname = EmailfromLogin
//        let gettnum = PwordfromLogin
//        var alertController = UIAlertController(title: "Cloudstaff Team Manager", message: "Please fill up the required information.", preferredStyle: .Alert)
//        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
//        })
//        
//        alertController.addAction(ok)
//        presentViewController(alertController, animated: true, completion: nil)
//    }
//    
//    func wrongEmail() {
//        let getname = EmailfromLogin
//        let gettnum = PwordfromLogin
//        var alertController = UIAlertController(title: "Cloudstaff Team Manager", message: "Wrong email address.", preferredStyle: .Alert)
//        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
//        })
//        alertController.addAction(ok)
//        presentViewController(alertController, animated: true, completion: nil)
//    }
//    
//    func wrongPassword() {
//        let getname = EmailfromLogin
//        let gettnum = PwordfromLogin
//        var alertController = UIAlertController(title: "Cloudstaff Team Manager", message: "Wrong password.", preferredStyle: .Alert)
//        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
//        })
//        alertController.addAction(ok)
//        presentViewController(alertController, animated: true, completion: nil)
//    }
//    
//    func bothWrong() {
//        let getname = EmailfromLogin
//        let gettnum = PwordfromLogin
//        var alertController = UIAlertController(title: "Cloudstaff Team Manager", message: "Wrong email and password.", preferredStyle: .Alert)
//        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
//        })
//        alertController.addAction(ok)
//        presentViewController(alertController, animated: true, completion: nil)
//    }
    
    

   
}
