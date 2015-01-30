//
//  Metrics.swift
//  CloudstaffTeamManager
//
//  Created by RitcheldaV on 29/1/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import Foundation


class Metrics {
    var title = "title"
    var lbldaily = "daily average"
    var lblweekly = "weekly average"
    var daily = 0
    var weekly = 0
    var value = 0
    
    init(title: String, lbldaily: String, lblweekly: String, daily: Int, weekly: Int, value: Int) {
        self.title = title
        self.lbldaily = lbldaily
        self.lblweekly = lblweekly
        self.daily = daily
        self.weekly = weekly
        self.value = value
    }
}