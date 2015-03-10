//
//  WorkingOnCell.swift
//  CloudstaffTeamManager
//
//  Created by RitcheldaV on 9/3/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit

class WorkingOnCell: UITableViewCell {
    
    @IBOutlet var lblDateTime: UILabel!
    @IBOutlet var lblTask: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
