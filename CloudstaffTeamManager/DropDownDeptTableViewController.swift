//
//  DropDownDeptTableViewController.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 3/6/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit


protocol DropDownDeptTableViewControllerDelegate{
    func dropControlDidSelectRow(indexPath:NSIndexPath)
}

class DropDownDeptTableViewController: UITableViewController {

    var delegate:DropDownDeptTableViewControllerDelegate?
    var tableData:Array<String> = []


}
