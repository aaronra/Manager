//
//  WorkingOnCell.swift
//  CloudstaffTeamManager
//
//  Created by RitcheldaV on 9/3/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit


struct WorkingDetails {
    var task = ""
    var date = ""

    
    init(task: String, date: String) {
        self.task = task
        self.date = date

    }
}


class WorkingOnCell: UITableViewCell {
    
    @IBOutlet var lblTask: UILabel!
    @IBOutlet var lblDateTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(lblDateTime: String, lblTask: String) {
        
        self.lblDateTime.text = lblDateTime
        self.lblTask.text = lblTask

    }
}
