//
//  DashboardCell.swift
//  CloudstaffTeamManager
//
//  Created by RitcheldaV on 29/1/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit

class DashboardCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var lbldaily: UILabel!
    @IBOutlet weak var lblweekly: UILabel!
    @IBOutlet weak var daily: UILabel!
    @IBOutlet weak var weekly: UILabel!
    @IBOutlet weak var value: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(title: String, lbldaily: String, lblweekly: String, daily: Int, weekly: Int, value: Int) {
        
        self.title.text = title  // casting String
        self.lbldaily.text = lbldaily
        self.lblweekly.text = lblweekly
        self.daily.text = String(daily) // casting String as (Int)
        self.weekly.text = String(weekly)
        self.value.text = String(value)
    }


}
