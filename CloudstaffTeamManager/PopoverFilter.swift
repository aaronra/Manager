//
//  PopoverFilter.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 4/24/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit



class PopoverFilter: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // popover settings
        modalPresentationStyle = .Popover
        popoverPresentationController!.delegate = self
        self.preferredContentSize = CGSize(width:320,height:100)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        var obj = RootVC()
        obj.itemSelected(indexPath.row)
        
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