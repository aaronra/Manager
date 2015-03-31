//
//  CustomCell.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 1/28/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setCell(leftLabelText: String, rightLabelInt: Int, imageName: String) {
        
        self.leftLabel.text = leftLabelText  // casting String
        self.rightLabel.text = String(rightLabelInt) // casting String as (Int)
        self.imgView.image = UIImage(named: imageName) // casting UIImageView
        
    }
    
}
