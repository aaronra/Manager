//
//  MyTeamViewController.swift
//  CloudstaffTeamManager
//
//  Created by RitcheldaV on 11/2/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit
import Realm

class MyTeamViewController: UIViewController, SideBarDelegate, UITableViewDelegate {
    
    @IBOutlet weak var dept: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var sideBar:SideBar = SideBar()
    
    var imageCache = [String : UIImage]()
    
    var arrayOfIds = Array<Int>()
    var arrayofStaffsImg = Array<String>()
    var arrayofLogin = Array<String>()
    var arrayofUsername = Array<String>()
    var arrayofName = Array<String>()
    
    var arrayofShift = Array<String>()
    var arrayofTeam = Array<String>()
    var arrayofPosition = Array<String>()
    var arrayofStatus = Array<String>()
    var arrayofFaveStatus = Array<String>()
    
    var clickedIndex: Int = 0
    var arrayOfFave = Array<Int>()
    
    var userSegue = ""
    var passSegue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideBar = SideBar(sourceView: self.view, menuItems:
            ["dashboard",
                "my team",
                "ping",
                "settings",
                "log out"])
        sideBar.delegate = self
        getMyTeam()
    }
    
    func getMyTeam() {
        var staff = Staff()
        var staffDetails = Staff.allObjects()
        
        let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        
        for myStaff:RLMObject in staffDetails {
            let staffInfo  = myStaff as RLMObject
            
            let id = staffInfo["id"] as Int
            let photo = staffInfo["photo"] as String
            let login = staffInfo["login"] as String
            let username = staffInfo["username"] as String
            let name = staffInfo["name"] as String
            let shift_start = staffInfo["shift_start"] as String
            let shift_end = staffInfo["shift_end"] as String
            let team = staffInfo["team"] as String
            let position = staffInfo["position"] as String
            let status = staffInfo["status"] as String
            let fave = staffInfo["favorite"] as String
            
            arrayOfIds.append(id)
            arrayofStaffsImg.append(photo)
            arrayofLogin.append(login + "list")
            arrayofUsername.append(username)
            arrayofName.append(name)
            arrayofShift.append(shift_start + " -" + shift_end)
            arrayofTeam.append(team)
            arrayofPosition.append(position)
            arrayofStatus.append(status)
            arrayofFaveStatus.append(fave)
            
            if fave == "Yes" {
                if contains(arrayOfFave,id) {
                } else {
                    arrayOfFave.append(id)
                }
            } else if fave == "No" {
                if contains(arrayOfFave,id) {
                    arrayOfFave = arrayOfFave.filter() { $0 != id }
                }
            }
        }
        
        println(arrayofFaveStatus)
        
        realm.commitWriteTransaction()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayofStaffsImg.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: MyTeamCell = tableView.dequeueReusableCellWithIdentifier("teamCell") as MyTeamCell
        
        let selectedView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
        selectedView.backgroundColor = UIColor.whiteColor()
        
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
        
        cell.Name.text = arrayofUsername[indexPath.row]
        cell.fullName.text = arrayofName[indexPath.row]
        
        cell.btnPing.tag = arrayOfIds[indexPath.row]
        cell.btnMail.tag = arrayOfIds[indexPath.row]
        cell.btnFave.tag = arrayOfIds[indexPath.row]
        cell.btnFave.addTarget(self, action: "FavePressed:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.detailOne.text = arrayofShift[indexPath.row]
        cell.detailTwo.text = arrayofTeam[indexPath.row]
        cell.detailThree.text = arrayofPosition[indexPath.row]
        cell.detailFour.text = arrayofStatus[indexPath.row]
        
        if contains(arrayOfFave, arrayOfIds[indexPath.row]) {
            cell.btnFave.setImage(UIImage(named: "favourite"), forState: UIControlState.Normal)
        } else {
            cell.btnFave.setImage(UIImage(named: "unfavourite"), forState: UIControlState.Normal)
        }
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        clickedIndex = indexPath.row
        performSegueWithIdentifier("toStaffDetails", sender: tableView)
        
    }
    
    func sideBarDidSelectButtonAtIndex(index: Int) {
        if index == 0{
            performSegueWithIdentifier("toDashboard", sender: self)
        } else if index == 1 {
            println("second")
            sideBar.showSideBar(false)
        } else if index == 2{
            println("third")
            performSegueWithIdentifier("toPing", sender: self)
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
    
    @IBAction func showMenu(sender: AnyObject) {
        if sideBar.isSideBarOpen == true {
            sideBar.showSideBar(false)
        }else{
            sideBar.showSideBar(true)
        }
    }
    
    
    
    // FAVE PRESSED *********************************
    func FavePressed(sender: UIButton) {
        let buttonRow = sender.tag
        
        if (contains(arrayOfFave, buttonRow)) {
            arrayOfFave = arrayOfFave.filter() { $0 != buttonRow }
        } else {
            arrayOfFave.append(buttonRow)
        }
        println(buttonRow)
        tableView.reloadData()
    }
    
    
    @IBAction func sendMessage(sender: AnyObject) {
//        performSegueWithIdentifier("toSendMessage", sender: self)
    }
    

    
    @IBAction func refresh(sender: UIBarButtonItem) {
        
        println("REFRESH --->>>> \(userSegue)")
        println("REFRESH --->>>> \(passSegue)")
        
    }
    
    @IBAction func filter(sender: AnyObject) {
        println("shjggdffgdfdfdfdf")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toStaffDetails" {
            var staffTVController : StaffTableViewController = segue.destinationViewController as StaffTableViewController
            staffTVController.staffID = clickedIndex
        }else if segue.identifier == "toDashboard" {
            let navigationController  = segue.destinationViewController as UINavigationController
            let myTeamTv = navigationController.topViewController as DashboardViewController
            
            myTeamTv.userSegue = userSegue
            myTeamTv.passSegue = passSegue
            
        }else if segue.identifier == "toPing" {
            let navigationController  = segue.destinationViewController as UINavigationController
            let pingTv = navigationController.topViewController as PingViewController
            
            pingTv.userSegue = userSegue
            pingTv.passSegue = passSegue
            
        }else if segue.identifier == "toSettings" {
            
            let navigationController  = segue.destinationViewController as UINavigationController
            let settingsTv = navigationController.topViewController as SettingsTableViewController
            
            settingsTv.userSegue = userSegue
            settingsTv.passSegue = passSegue
            
        } else if segue.identifier == "toSendMessage" {
            var sendMTVController : SendMessageTableViewController = segue.destinationViewController as SendMessageTableViewController
            sendMTVController.staffID = clickedIndex
        }
        
    }
    
}
