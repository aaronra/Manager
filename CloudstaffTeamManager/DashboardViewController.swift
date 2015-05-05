//
//  DashboardViewController.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 27/1/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit
import Darwin
import Realm

class DashboardViewController: UIViewController, SideBarDelegate, UITableViewDelegate, UICollectionViewDelegate {
    
    let borderWidth = 1.0
    var onBackground = OnBackground()
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    var arrayOfMetrics: [Metrics] = [Metrics]()
    var imageCache = [String : UIImage]()
    var arrayofStaffs = Array<String>()
    var arrayofLogin = Array<String>()
    var sideBar:SideBar = SideBar()
    
    var refreshControl: UIRefreshControl!
    var mtrID: Int = 0
    
    var longPressTarget: (cell: UICollectionViewCell, indexPath: NSIndexPath)!
    var longPressTargetIndex: Int = 0
    
    let prefKey = NSUserDefaults.standardUserDefaults()
    let settKey = NSUserDefaults.standardUserDefaults()
    
    
    // dummy API return data
    var timeInterval = "2"
    var defaultMessage = "This is sample Message for Settings...."
    var autoUpdate = "true"

    let myID = UIDevice.currentDevice().identifierForVendor.UUIDString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideBar = SideBar(sourceView: self.view, menuItems:
            ["dashboard",
                "my team",
                "ping",
                "settings",
                "log out"])
        sideBar.delegate = self
        self.firstMetrics()
        
        getImageforCollectionView()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: "longPressHandler:")
        collectionView.addGestureRecognizer(longPress)
    }
    
    @IBAction func showMenu(sender: AnyObject) {
        
        if sideBar.isSideBarOpen == true {
            sideBar.showSideBar(false)
        }else{
            sideBar.showSideBar(true)
        }
    }

    
    func sideBarDidSelectButtonAtIndex(index: Int) {
        if index == 0{
            sideBar.showSideBar(false)
        } else if index == 1 {
            println("second")
            performSegueWithIdentifier("toMyTeam", sender: self)
        } else if index == 2{
            println("third")
            performSegueWithIdentifier("toPing", sender: self)
        } else if index == 3 {
            println("fourth")
            performSegueWithIdentifier("toSettings", sender: self)
        } else if index == 4 {
           performSegueWithIdentifier("toLogin", sender: self)
        }
    }
    
    func firstMetrics(){
        
        let stf = Staff.objectsWhere("id == \(mtrID)")
        for mtrc_stf:RLMObject in stf {
            let mtrixInfo = mtrc_stf as RLMObject
            let name = mtrixInfo["name"] as! String
            lblName.text = name
            let mtrix = mtrixInfo["metrics"] as! RLMArray
            if mtrix.count != 0 {
                for mtxstf:RLMObject in mtrix {
                    let mtxInfo = mtxstf as RLMObject
                    let title  =  mtxInfo["title"]  as!  String
                    let daily  =  mtxInfo["daily"]  as!  Int
                    let weekly =  mtxInfo["weekly"] as!  Int
                    let value  =  mtxInfo["value"]  as!  Int
                    var metrics = Metrics(title: String(title), lbldaily:"daily average", lblweekly:"weekly average", daily: daily, weekly: weekly, value: value)
                    arrayOfMetrics.append(metrics)
                    self.tblView.reloadData()
                }
            }else {
                arrayOfMetrics.removeAll(keepCapacity: true)
                self.tblView.reloadData()
                
                switch UIDevice.currentDevice().systemVersion.compare("8.0.0", options: NSStringCompareOptions.NumericSearch) {
                case .OrderedSame, .OrderedDescending:
                    println("8 above")
                    
                    var alertController = UIAlertController(title: "Cloudstaff Team Manager", message: "No available Metrics", preferredStyle: .Alert)
                    let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    })
                    
                    alertController.addAction(ok)
                    presentViewController(alertController, animated: true, completion: nil)
                    
                case .OrderedAscending:
                    let alertView = UIAlertView(title: "Cloudstaff Team Manager", message: "No available Metrics", delegate: self, cancelButtonTitle: "OK")
                    alertView.alertViewStyle = .Default
                    alertView.show()
                    println("8 below")
                }
            }
        }
    }
    
    
//////////////////////////////////////////////////////////////////
    
    func setAutoUpdate() {
    
       // insert Parsed data to NSUserDefault as 1 String
       settKey.setValue("\(timeInterval):\(defaultMessage):\(autoUpdate)", forKey: "isOn")
        
        // breakdown String to get autoSwitch value
        let settValue = settKey.stringForKey("isOn")
        let stringArray = settValue!.componentsSeparatedByString(":")
        let autoSwitch: String = stringArray [2]
        var settValString = NSString(string: autoSwitch)
        
//        if settValString.boolValue == true {
//            onBackground.autoUpdate()
//        }else {
//            onBackground.stopUpdate()
//        }
        
    }
    

//////////////////////////////////////////////////////////////////
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfMetrics.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: DashboardCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! DashboardCell
        
        if indexPath.row % 2 == 0
        {
            cell.backgroundColor = UIColor(hex: 0xDDDDDD)
        }else{
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        let metrics = arrayOfMetrics[indexPath.row]
        cell.setCell(metrics.title, lbldaily: metrics.lbldaily, lblweekly: metrics.lblweekly, daily: metrics.daily, weekly: metrics.weekly, value: metrics.value)
        return cell
    }

    func getImageforCollectionView() {
        var staff = Staff()
        var staffDetails = Staff.allObjects()
        
        let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        
        for myStaff:RLMObject in staffDetails {
            let staffInfo  = myStaff as RLMObject
            
            let photo = staffInfo["photo"] as! String
            let login = staffInfo["login"] as! String
            
            
            arrayofStaffs.append(photo)
            arrayofLogin.append(login)
        }
        realm.commitWriteTransaction()
        
//        arrayofStaffs.insert(arrayofStaffs.last!, atIndex: 0)
//        arrayofStaffs.append(arrayofStaffs[1])
//        arrayofLogin.insert(arrayofLogin.last!, atIndex: 0)
//        arrayofLogin.append(arrayofLogin[1])

    
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayofStaffs.count
    }

    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: StaffCell = collectionView.dequeueReusableCellWithReuseIdentifier("staffCell", forIndexPath: indexPath) as! StaffCell
        
        cell.statusCell.image = UIImage(named: arrayofLogin[indexPath.row])
        
        cell.imgCell?.image = UIImage(named: "staff")
        
        let urlString = arrayofStaffs[indexPath.row]
        
        // Check our image cache for the existing key. This is just a dictionary of UIImages
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
    
//   Populate MetricsArray for each Staff every Click
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let stf = Staff.objectsWhere("id == \(indexPath.row)")
        reloadMetrics(stf)
        
    }
    
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath){
        longPressTarget = (cell: self.collectionView(collectionView, cellForItemAtIndexPath: indexPath), indexPath: indexPath)
    }
    
    
    func longPressHandler(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.Began {
            
            if let _longPressTarget = longPressTarget {
                longPressTargetIndex = _longPressTarget.indexPath.row
                performSegueWithIdentifier("toStaffDetails", sender: self)
            }
        }
    }

    

    func reloadMetrics(stf: RLMResults) {
        arrayOfMetrics.removeAll(keepCapacity: true)
        for mtrc_stf:RLMObject in stf {
            let mtrixInfo = mtrc_stf as RLMObject
            let name = mtrixInfo["name"] as! String
            lblName.text = name
            let mtrix = mtrixInfo["metrics"] as! RLMArray
            
            if mtrix.count != 0 {
                for mtxstf:RLMObject in mtrix {
                    let mtxInfo = mtxstf as RLMObject
                    let title  =  mtxInfo["title"]  as!  String
                    let daily  =  mtxInfo["daily"]  as!  Int
                    let weekly =  mtxInfo["weekly"] as!  Int
                    let value  =  mtxInfo["value"]  as!  Int
                    var metrics = Metrics(title: String(title), lbldaily:"daily average", lblweekly:"weekly average", daily: daily, weekly: weekly, value: value)
                    arrayOfMetrics.append(metrics)
                    self.tblView.reloadData()
                }
            }else {
                arrayOfMetrics.removeAll(keepCapacity: true)
                self.tblView.reloadData()
                
                switch UIDevice.currentDevice().systemVersion.compare("8.0.0", options: NSStringCompareOptions.NumericSearch) {
                case .OrderedSame, .OrderedDescending:
                    println("8 above")
                    
                    var alertController = UIAlertController(title: "Cloudstaff Team Manager", message: "No available Metrics", preferredStyle: .Alert)
                    let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    })
                    
                    alertController.addAction(ok)
                    presentViewController(alertController, animated: true, completion: nil)
                    
                case .OrderedAscending:
                    let alertView = UIAlertView(title: "Cloudstaff Team Manager", message: "No available Metrics", delegate: self, cancelButtonTitle: "OK")
                    alertView.alertViewStyle = .Default
                    alertView.show()
                    println("8 below")
                }
            }
        
        }
    }

    
    @IBAction func refresh(sender: UIBarButtonItem) {
        
        let prefValue = prefKey.stringForKey("holdingData")
        let tags = prefValue!.componentsSeparatedByString(":")
        let user = tags[0]
        let pass = tags[1]

        dispatch_async(dispatch_get_main_queue(), {
//            JsonToRealm.parseData("\(user)/\(pass)")
        })
        self.tblView.reloadData()

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "toStaffDetails" {
//            let navigationController  = segue.destinationViewController as UINavigationController
//            var staffTVController = navigationController.topViewController as StaffTableViewController
            
            let staffTVController : StaffTableViewController = segue.destinationViewController as! StaffTableViewController
            staffTVController.cameFrom = "DashBoard"
            staffTVController.staffID = longPressTargetIndex
        }
    }
}


//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
//        UIView.animateWithDuration(0.25, animations: {
//            cell.layer.transform = CATransform3DMakeScale(1,1,1)
//        })
//    }





