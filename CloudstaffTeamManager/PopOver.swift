//
//  RightPopOver.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 4/27/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit

class PopOver: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate {
    
    
    var root = MyTeamViewController()
    
    @IBOutlet weak var tableView: UITableView!
    
    let leftData = ["All", "Development", "Management", "SQA", "Admin"]
    let rightData = ["None", "Online Staffs", "Offline Staffs", "Assigned Staffs", "Unassigned Staffs", "My Favorites"]
    
    var fromRoot = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .Popover
        popoverPresentationController!.delegate = self
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if fromRoot == "left" {
            return leftData.count
        }else {
            return rightData.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("textCell", forIndexPath: indexPath) as! UITableViewCell
        
        let row = indexPath.row
        
        if fromRoot == "left" {
            cell.textLabel?.text = leftData[row]
            self.preferredContentSize = CGSize(width:320,height:225)
        }else if fromRoot == "right" {
            cell.textLabel?.text = rightData[row]
            self.preferredContentSize = CGSize(width:320,height:270)
        }else {
            cell.textLabel?.text = rightData[row]
            self.preferredContentSize = CGSize(width:320,height:270)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        
        root.itemSelected(tableView.cellForRowAtIndexPath(indexPath)!.textLabel!.text!)
        
        dismissViewControllerAnimated(true, completion:nil)
    }
    
    
    func adaptivePresentationStyleForPresentationController(PC: UIPresentationController) -> UIModalPresentationStyle{
        return .None
    }
    
    func presentationController(_: UIPresentationController, viewControllerForAdaptivePresentationStyle _: UIModalPresentationStyle)
        -> UIViewController?{
            return UINavigationController(rootViewController: self)
    }
    
}

