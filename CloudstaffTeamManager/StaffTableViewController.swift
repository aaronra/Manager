//
//  StaffTableViewController.swift
//  CloudstaffTeamManager
//
//  Created by RitcheldaV on 13/2/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgStatus.image = UIImage(named: vImgStatus)
        
        imgStaff?.image = UIImage(named: "staff")
        
        let urlString = vImgStaff
        
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
        
        lblName.text = vLblName
        lblFullName.text = vLblFullName
        detailOne.text = vDetailOne
        detailTwo.text = vDetailTwo
        detailThree.text = vDetailThree
        detailFour.text = vDetailFour
    
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
        
        } else if (indexPath.row == 2) {
            
        } else if (indexPath.row == 3) {
            
        } else if (indexPath.row == 4) {
            
        } else if (indexPath.row == 5) {
            if (imgFave.imageForState(UIControlState.Normal) == UIImage(named: "favourite")) {
                imgFave.setImage(UIImage(named: "unfavourite"), forState: UIControlState.Normal)
            } else {
                imgFave.setImage(UIImage(named: "favourite"), forState: UIControlState.Normal)
            }
        }
    }

    @IBAction func back(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}
