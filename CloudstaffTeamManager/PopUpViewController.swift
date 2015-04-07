//
//  PopUpViewController.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 4/7/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    
    @IBOutlet var popuplayout: UIView!
    
    override func viewDidLoad() {
        
        popuplayout.backgroundColor = UIColor(hex: 0x1C98D5)
        popuplayout.alpha = 0.3
        
    }
}
