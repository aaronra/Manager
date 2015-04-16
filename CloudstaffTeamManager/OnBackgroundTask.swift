//
//  OnBackgroundTask.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 4/15/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import Foundation

class OnBackground: NSObject {
    
    var timer:NSTimer = NSTimer()
    
    func autoUpdate() {
        if (!timer.valid) {
            timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        }
        
    }
    
    func update() {
        println("REPEATED TASK")
    }
    
    func stopUpdate() {
        timer.invalidate()

    }
}