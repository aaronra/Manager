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
            let id = staffInfo["id"] as Int
            let photo = staffInfo["photo"] as String
            let login = staffInfo["login"] as String
            let username = staffInfo["username"] as String
            let name = staffInfo["name"] as String
            
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
        let cell: PingStaffCell = tableView.dequeueReusableCellWithIdentifier("pingStaffCell") as PingStaffCell
        
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
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell: PingStaffCell = tableView.cellForRowAtIndexPath(indexPath) as PingStaffCell
        
        if (cell.btnSelect.imageForState(UIControlState.Normal) == UIImage(named: "checked")) {
            cell.btnSelect.setImage(UIImage(named: "unchecked"), forState: UIControlState.Normal)
        } else {
            cell.btnSelect.setImage(UIImage(named: "checked"), forState: UIControlState.Normal)
        }
        
    }
    
    func SelectThis(sender: UIButton) {
        let buttonRow = sender.tag
        
        if (sender.imageForState(UIControlState.Normal) == UIImage(named: "checked")) {
            sender.setImage(UIImage(named: "unchecked"), forState: UIControlState.Normal)
        } else {
            sender.setImage(UIImage(named: "checked"), forState: UIControlState.Normal)
        }
        println(buttonRow)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
            exit(0)
        }
    }
    
    @IBAction func pingAll(sender: AnyObject) {
        if (sender.imageForState(UIControlState.Normal) == UIImage(named: "checked")) {
            sender.setImage(UIImage(named: "unchecked"), forState: UIControlState.Normal)
            
            for NSIndexPath idx in 0..<arrayOfIds.count {
            
                let cell: PingStaffCell = tableView(tblView, cellForRowAtIndexPath:idx) as PingStaffCell
                cell.btnSelect.setImage(UIImage(named: "unchecked"), forState: UIControlState.Normal)
            }
            
        } else {
            sender.setImage(UIImage(named: "checked"), forState: UIControlState.Normal)
        }
    }
    
    
    @IBAction func showMenu(sender: AnyObject) {
        if sideBar.isSideBarOpen == true {
            sideBar.showSideBar(false)
        }else{
            sideBar.showSideBar(true)
        }
    }
    
}
