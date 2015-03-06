//
//  MyTeamCell.swift
//  CloudstaffTeamManager
//
//  Created by RitcheldaV on 11/2/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit

class MyTeamCell: UITableViewCell {
    @IBOutlet weak var imgStaff: UIImageView!
    @IBOutlet weak var imgStatus: UIImageView!
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var fullName: UILabel!    
    
    @IBOutlet weak var btnPing: UIButton!
    @IBOutlet weak var btnMail: UIButton!
    @IBOutlet weak var btnFave: UIButton!
    
    @IBOutlet weak var detailOne: UILabel!
    @IBOutlet weak var detailTwo: UILabel!
    @IBOutlet weak var detailThree: UILabel!
    @IBOutlet weak var detailFour: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
