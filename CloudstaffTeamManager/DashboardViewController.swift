//
//  DashboardViewController.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 27/1/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit
import Darwin

class DashboardViewController: UIViewController, SideBarDelegate, UITableViewDelegate, UICollectionViewDelegate {
    
    let borderWidth = 1.0
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    var arrayOfMetrics: [Metrics] = [Metrics]()
    var staffIcon = [StaffImages]()
    var api : APIController?
    var imageCache = [String : UIImage]()
    var arrayofStaffs: [String] = ["http://cloudstaff.com/staff/ChristoperC.jpg","http://cloudstaff.com/staff/OscarG.jpg","","http://cloudstaff.com/staff/RicheldaV.jpg","http://cloudstaff.com/staff/ArnelN.jpg","http://cloudstaff.com/staff/RenzS.jpg","http://cloudstaff.com/staff/ElvinD.jpg"]
    
//    var arrayofStaffs: [String] = ["staff","staff","staff","staff","staff","staff","staff"]
    
    var arrayofStatus: [String] = ["online","offline","online","online","offline","online","online"]
    
    var sideBar:SideBar = SideBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideBar = SideBar(sourceView: self.view, menuItems:
            ["dashboard",
                "my team",
                "ping",
                "settings",
                "log out"])
        sideBar.delegate = self
        
        self.populateMetrics()
        
    }
    
    func populateMetrics(){
        var i = 0
        var d = 0
        var w = 0
        var v = 0
        
        while (i != 15)
        {
            ++d
            ++w
            ++v
            ++i
            
            var metrics = Metrics(title:"Sample Title " + String(i), lbldaily:"daily average", lblweekly:"weekly average", daily: d, weekly: w, value: v)
            
            arrayOfMetrics.append(metrics)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayOfMetrics.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: DashboardCell = tableView.dequeueReusableCellWithIdentifier("Cell") as DashboardCell
        
        if indexPath.row % 2 == 0
        {
            cell.backgroundColor = UIColor(hex: 0xDDDDDD)
        }else{
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        let metrics = arrayOfMetrics[indexPath.row]
        
        cell.setCell(metrics.title, lbldaily: metrics.lbldaily, lblweekly: metrics.lblweekly, daily: metrics.daily, weekly: metrics.weekly, value: metrics.value)
        
        println(metrics.value)
        
        return cell
        
    }

    
    func sideBarDidSelectButtonAtIndex(index: Int)
    {
        if index == 0{
            sideBar.showSideBar(false)
        } else if index == 1 {
            println("second")
        } else if index == 2{
            println("third")
        } else if index == 3 {
            println("fourth")
            //performSegueWithIdentifier("toSettings", sender: self)
        } else if index == 4 {
            exit(0)
        }
    }
    
    
    @IBAction func showMenu(sender: AnyObject) {
        
        if sideBar.isSideBarOpen == true {
            sideBar.showSideBar(false)
        }else{
            sideBar.showSideBar(true)
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayofStaffs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: StaffCell = collectionView.dequeueReusableCellWithReuseIdentifier("staffCell", forIndexPath: indexPath) as StaffCell
        
        cell.statusCell.image = UIImage(named: arrayofStatus[indexPath.row])
//        cell.imgCell.image = UIImage(named: arrayofStaffs[indexPath.row])
        
        cell.imgCell?.image = UIImage(named: "staff")
        
        // *******
        
        // Grab the artworkUrl60 key to get an image URL for the app's thumbnail
        let urlString = arrayofStaffs[indexPath.row]
        
        // Check our image cache for the existing key. This is just a dictionary of UIImages
        //var image: UIImage? = self.imageCache.valueForKey(urlString) as? UIImage
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
                        if let cellToUpdate = collectionView.cellForItemAtIndexPath(indexPath) {
                            cell.imgCell.image = image
                            
                            //cellToUpdate.imageView?.image = image
                        }
                    })
                }
                else {
                    println("Error: \(error.localizedDescription)")
                }
            })
            
        }
        else {
            dispatch_async(dispatch_get_main_queue(), {
                if let cellToUpdate = collectionView.cellForItemAtIndexPath(indexPath) {
                    cell.imgCell.image = image
                    //cellToUpdate.imageView?.image = image
                }
            })
        }
        
        // *******
        
        return cell 
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("Cell \(indexPath.row) selected")
    }

    @IBAction func scrollLeft(sender: AnyObject) {
        
        var navToleft = collectionView.contentOffset.x - 80
        
        if (navToleft < 0) {
            navToleft = 0
        }
        
        if ((navToleft) >= 0) {
            [collectionView.setContentOffset(CGPointMake(navToleft, 0), animated: true)]
        }
        println(navToleft)
   
    }
    
    @IBAction func scrollRight(sender: AnyObject) {
        if ((collectionView.contentOffset.x + 80) < (collectionView.contentSize.width - (collectionView.contentOffset.x - 80))) {
            [collectionView.setContentOffset(CGPointMake(collectionView.contentOffset.x + 80, 0), animated: true)]
        }
    }
    
    
    func didReceiveAPIResults(results: NSDictionary) {
        var teamArr: NSArray = results["myTeam"] as NSArray
        dispatch_async(dispatch_get_main_queue(), {
            self.staffIcon = MyTeamDetails.staffImagesJSON(teamArr)
            //            self.tblView!.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
        
        println(" protocol LANGS == for getting staff ID ")
        //        println(teamArr)
    }

}












