//
//  StaffTableViewController.swift
//  CloudstaffTeamManager
//
//  Created by RitcheldaV on 13/2/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit
import Realm

class StaffTableViewController: UITableViewController {

    @IBOutlet weak var imgStaff: UIImageView!
    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var detailOne: UILabel!
    @IBOutlet weak var detailTwo: UILabel!
    @IBOutlet weak var detailThree: UILabel!
    @IBOutlet weak var detailFour: UILabel!
    @IBOutlet weak var imgFave: UIButton!
    
    var vImgStaff = String()
    var vImgStatus = String()
    var vLblName = String()
    var vLblFullName = String()
    var vDetailOne = String()
    var vDetailTwo = String()
    var vDetailThree = String()
    var vDetailFour = String()
    var imageCache = [String : UIImage]()
    
    var staffID = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let staffDetail = Staff.objectsWhere("id == \(staffID)")
        
        for staff: RLMObject in staffDetail {
            let stfInfo = staff as RLMObject
            
                let username     =   stfInfo["username"]  as  String
                let name         =   stfInfo["name"]  as  String
                let photo        =   stfInfo["photo"] as  String
                let shift_start  =   stfInfo["shift_start"]  as  String
                let shift_end    =   stfInfo["shift_end"]  as  String
                let team         =   stfInfo["team"]  as  String
                let position     =   stfInfo["position"] as  String
                let status       =   stfInfo["status"]  as  String
                let favorite     =   stfInfo["favorite"]  as  String
                let login        =   stfInfo["login"]  as  String
            
            
            imgStatus.image = UIImage(named: login+"list")
            imgStaff?.image = UIImage(named: "staff")
            let urlString = photo
            
            var image = self.imageCache[urlString]
            
            if( image == nil ) {
                // If the image does not exist, we need to download it
                var imgURL: NSURL = NSURL(string: urlString)!
                
                // Download an NSData representation of the image at the URL
                let request: NSURLRequest = NSURLRequest(URL: imgURL)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                    if error == nil {
                        image = UIImage(data: data)
                        
                        // Store the image in to our cache
                        self.imageCache[urlString] = image
                        dispatch_async(dispatch_get_main_queue(), {
                            self.imgStaff.image = image
                        })
                    }
                    else {
                        println("Error: \(error.localizedDescription)")
                    }
                })
            }
            else {
                dispatch_async(dispatch_get_main_queue(), {
                    self.imgStaff.image = image
                })
            }
            
            
            lblName.text = username
            lblFullName.text = name
            detailOne.text = shift_start + " -" + shift_end
            detailTwo.text = team
            detailThree.text = position
            detailFour.text = status
        }

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        
        return cell
        
     }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.row == 1) {
            
            println("---->>> \(indexPath.row)")
        
        } else if (indexPath.row == 2) {
            
            println("---->>> \(indexPath.row)")
            
        } else if (indexPath.row == 3) {
            
            println("---->>> \(indexPath.row)")
            
        } else if (indexPath.row == 4) {
            
//            println("---->>> \(indexPath.row)")
//            println("---->>>ID \(staffID)")
            performSegueWithIdentifier("backtoDashboard", sender: tableView)
            
        } else if (indexPath.row == 5) {
            if (imgFave.imageForState(UIControlState.Normal) == UIImage(named: "favourite")) {
                imgFave.setImage(UIImage(named: "unfavourite"), forState: UIControlState.Normal)
            } else {
                imgFave.setImage(UIImage(named: "favourite"), forState: UIControlState.Normal)
            }
        }
    }

    @IBAction func back(sender: AnyObject) {
        performSegueWithIdentifier("toMyTeam", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "backtoDashboard" {
            var dashboardController : DashboardViewController = segue.destinationViewController as DashboardViewController
            dashboardController.mtrID = staffID
        }
    }
    
    
    
    
    
}