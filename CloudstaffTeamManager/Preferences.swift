//
//  Preferences.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 3/31/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit
import Foundation

public class Preferences {
    
    class func isInitialInstall() -> Bool {
        
        let prefs = NSUserDefaults.standardUserDefaults()
        
        let prefKey = prefs.stringForKey("initialInstall") != ""

        return (prefKey) ? true : false
    }
    

    
}



//if let prefKey = prefs.stringForKey("initialInstall"){
//    println("SECOND RUN: " + prefKey)
//}else{
//    //Nothing stored in NSUserDefaults yet. Set a value.
//    prefs.setValue("t0tep", forKey: "initialInstall")
//    println("INITIAL INSTALL: " + prefs.description)
//}