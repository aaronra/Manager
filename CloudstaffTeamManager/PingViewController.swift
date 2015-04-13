//
//  PingViewController.swift
//  CloudstaffTeamManager
//
//  Created by RitcheldaV on 25/2/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit
import Realm


class PingViewController: UIViewController, SideBarDelegate, UITableViewDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnSelectAll: UIButton!
    
    
    var sideBar:SideBar = SideBar()
    
    var imageCache = [String : UIImage]()
    
    var arrayOfIds = Array<Int>()
    var arrayofStaffsImg = Array<String>()
    var arrayofLogin = Array<String>()
    var arrayofUsername = Array<String>()
    var arrayofName = Array<String>()
    
    var willPingAll:Bool = false
    var selectedFew:Bool = false
    
    var arrayofPingIds = Array<Int>()
    
    
    var alert = AlertDialogs()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideBar = SideBar(sourceView: self.view, menuItems:
            ["dashboard",
                "my team",
                "ping",
                "settings",
                "log out"])
        sideBar.delegate = self
        getStaffList()
    }

    func getStaffList() {
        var staff = Staff()
        var staffDetails = Staff.allObjects()
        
        let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        
        for myStaff:RLMObject in staffDetails {
            let staffInfo = myStaff as RLMObject
            let id = staffInfo["id"] as! Int
            let photo = staffInfo["photo"] as! String
            let login = staffInfo["login"] as! String
            let username = staffInfo["username"] as! String
            let name = staffInfo["name"] as! String
            
            arrayOfIds.append(id)
            arrayofStaffsImg.append(photo)
            arrayofLogin.append(login + "list")
            arrayofUsername.append(username)
            arrayofName.append(name)
        }
        realm.commitWriteTransaction()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayofStaffsImg.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: PingStaffCell = tableView.dequeueReusableCellWithIdentifier("pingStaffCell") as! PingStaffCell
        
        let selectedView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
        selectedView.backgroundColor = UIColor.whiteColor()
        
        cell.selectedBackgroundView = selectedView
        cell.imgStatus.image = UIImage(named: arrayofLogin[indexPath.row])
        cell.imgStaff?.image = UIImage(named: "staff")
        let urlString = arrayofStaffsImg[indexPath.row]
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
                        if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath){
                            cell.imgStaff.image = image
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
                if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) {
                    cell.imgStaff.image = image                }
            })
        }
        
        cell.lblName.text = arrayofUsername[indexPath.row]
        cell.lblFullName.text = arrayofName[indexPath.row]
        
        cell.btnSelect.tag = arrayOfIds[indexPath.row]
        cell.btnSelect.addTarget(self, action: "SelectThis:", forControlEvents: UIControlEvents.TouchUpInside)
        
        if selectedFew {
            if contains(arrayofPingIds,arrayOfIds[indexPath.row]) {
                cell.btnSelect.setImage(UIImage(named: "checked"), forState: UIControlState.Normal)
            } else {
                cell.btnSelect.setImage(UIImage(named: "unchecked"), forState: UIControlState.Normal)
            }
        } else {
            if willPingAll {
                cell.btnSelect.setImage(UIImage(named: "checked"), forState: UIControlState.Normal)
            } else {
                cell.btnSelect.setImage(UIImage(named: "unchecked"), forState: UIControlState.Normal)
            }
        }
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        let cell: PingStaffCell = tableView.cellForRowAtIndexPath(indexPath) as PingStaffCell
        
        if (contains(arrayofPingIds,arrayOfIds[indexPath.row])) {
            arrayofPingIds = arrayofPingIds.filter() { $0 != self.arrayOfIds[indexPath.row] }
        } else {
            arrayofPingIds.append(arrayOfIds[indexPath.row])
        }
        
        tblView.reloadData()
        selectedFew = true
        
    }
    
    func SelectThis(sender: UIButton) {
        let buttonRow = sender.tag
        
        if (contains(arrayofPingIds,buttonRow)) {
            arrayofPingIds = arrayofPingIds.filter() { $0 != buttonRow }
        } else {
            arrayofPingIds.append(buttonRow)
        }
        println(buttonRow)
        
        tblView.reloadData()
        selectedFew = true
    }
    
    
    
    func sideBarDidSelectButtonAtIndex(index: Int) {
        if index == 0{
            performSegueWithIdentifier("toDashboard", sender: self)
        } else if index == 1 {
            println("second")
            performSegueWithIdentifier("toMyTeam", sender: self)
        } else if index == 2{
            println("third")
            sideBar.showSideBar(false)
        } else if index == 3 {
            println("fourth")
            performSegueWithIdentifier("toSettings", sender: self)
        } else if index == 4 {
            switch UIDevice.currentDevice().systemVersion.compare("8.0.0", options: NSStringCompareOptions.NumericSearch) {
            case .OrderedSame, .OrderedDescending:
                println("8 above")
                var alertController = UIAlertController(title: "Logout?", message: "Exit Manager", preferredStyle: .Alert)
                let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    exit(0)
                })
                let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in}
                alertController.addAction(ok)
                alertController.addAction(cancel)
                presentViewController(alertController, animated: true, completion: nil)
                
            case .OrderedAscending:
                
                let alertView = UIAlertView(title: "Logout?", message: "Exit Manager", delegate: self, cancelButtonTitle: "Cancel")
                alertView.addButtonWithTitle("OK")
                alertView.alertViewStyle = .Default
                alertView.show()
                
                println("8 below")
            }
        }
    }
    
    @IBAction func pingAll(sender: AnyObject) {
        if (sender.imageForState(UIControlState.Normal) == UIImage(named: "checked")) {
            sender.setImage(UIImage(named: "unchecked"), forState: UIControlState.Normal)
            willPingAll = false
            arrayofPingIds.removeAll(keepCapacity: true)
        } else {
            sender.setImage(UIImage(named: "checked"), forState: UIControlState.Normal)
            willPingAll = true
            for x in 0..<arrayOfIds.count {
                arrayofPingIds.append(x)
            }

        }
        
        tblView.reloadData()
        
        selectedFew = false
    }
    
    
    @IBAction func showMenu(sender: AnyObject) {
        if sideBar.isSideBarOpen == true {
            sideBar.showSideBar(false)
        }else{
            sideBar.showSideBar(true)
        }
    }
    
    
    
    @IBAction func ping(sender: AnyObject) {
        
        switch UIDevice.currentDevice().systemVersion.compare("8.0.0", options: NSStringCompareOptions.NumericSearch) {
        case .OrderedSame, .OrderedDescending:
            alert.showAlertController(self)
        case .OrderedAscending:
            alert.showAlertView()
        }
        
    }
    

    
}
