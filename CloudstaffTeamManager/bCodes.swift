////
////  MyTeamViewController.swift
////  CloudstaffTeamManager
////
////  Created by RitcheldaV on 11/2/15.
////  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
////
//
//import UIKit
//import Realm
//
//class MyTeamViewController: UIViewController, SideBarDelegate, UITableViewDelegate {
//    
//    @IBOutlet weak var dept: UILabel!
//    @IBOutlet weak var tableView: UITableView!
//    
//    var sideBar:SideBar = SideBar()
//    
//    var imageCache = [String : UIImage]()
//    
//    var arrayOfIds = Array<Int>()
//    var arrayofStaffsImg = Array<String>()
//    var arrayofLogin = Array<String>()
//    var arrayofUsername = Array<String>()
//    var arrayofName = Array<String>()
//    
//    var arrayofShift = Array<String>()
//    var arrayofTeam = Array<String>()
//    var arrayofPosition = Array<String>()
//    var arrayofStatus = Array<String>()
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        sideBar = SideBar(sourceView: self.view, menuItems:
//            ["dashboard",
//                "my team",
//                "ping",
//                "settings",
//                "log out"])
//        sideBar.delegate = self
//        getMyTeam()
//    }
//    
//    func getMyTeam() {
//        var staff = Staff()
//        var staffDetails = Staff.allObjects()
//        
//        let realm = RLMRealm.defaultRealm()
//        realm.beginWriteTransaction()
//        
//        for myStaff:RLMObject in staffDetails {
//            let staffInfo  = myStaff as RLMObject
//            
//            let id = staffInfo["id"] as Int
//            let photo = staffInfo["photo"] as String
//            let login = staffInfo["login"] as String
//            let username = staffInfo["username"] as String
//            let name = staffInfo["name"] as String
//            let shift_start = staffInfo["shift_start"] as String
//            let shift_end = staffInfo["shift_end"] as String
//            let team = staffInfo["team"] as String
//            let position = staffInfo["position"] as String
//            let status = staffInfo["status"] as String
//            
//            arrayOfIds.append(id)
//            arrayofStaffsImg.append(photo)
//            arrayofLogin.append(login + "list")
//            arrayofUsername.append(username)
//            arrayofName.append(name)
//            arrayofShift.append(shift_start + " -" + shift_end)
//            arrayofTeam.append(team)
//            arrayofPosition.append(position)
//            arrayofStatus.append(status)
//        }
//        realm.commitWriteTransaction()
//    }
//    
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return arrayofStaffsImg.count
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell: MyTeamCell = tableView.dequeueReusableCellWithIdentifier("teamCell") as MyTeamCell
//        cell.imgStatus.image = UIImage(named: arrayofLogin[indexPath.row])
//        cell.imgStaff?.image = UIImage(named: "staff")
//        let urlString = arrayofStaffsImg[indexPath.row]
//        var image = self.imageCache[urlString]
//        if( image == nil ) {
//            // If the image does not exist, we need to download it
//            var imgURL: NSURL = NSURL(string: urlString)!
//            // Download an NSData representation of the image at the URL
//            let request: NSURLRequest = NSURLRequest(URL: imgURL)
//            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
//                if error == nil {
//                    image = UIImage(data: data)
//                    
//                    // Store the image in to our cache
//                    self.imageCache[urlString] = image
//                    dispatch_async(dispatch_get_main_queue(), {
//                        if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath){
//                            cell.imgStaff.image = image
//                        }
//                    })
//                }
//                else {
//                    println("Error: \(error.localizedDescription)")
//                }
//            })
//            
//        }
//        else {
//            dispatch_async(dispatch_get_main_queue(), {
//                if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) {
//                    cell.imgStaff.image = image                }
//            })
//        }
//        
//        cell.Name.text = arrayofUsername[indexPath.row]
//        cell.fullName.text = arrayofName[indexPath.row]
//        
//        cell.btnPing.tag = arrayOfIds[indexPath.row]
//        cell.btnMail.tag = arrayOfIds[indexPath.row]
//        cell.btnFave.tag = arrayOfIds[indexPath.row]
//        cell.btnFave.addTarget(self, action: "FavePressed:", forControlEvents: UIControlEvents.TouchUpInside)
//        cell.detailOne.text = arrayofShift[indexPath.row]
//        cell.detailTwo.text = arrayofTeam[indexPath.row]
//        cell.detailThree.text = arrayofPosition[indexPath.row]
//        cell.detailFour.text = arrayofStatus[indexPath.row]
//        
//        return cell
//        
//    }
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        println("------>>>>>> indexPath \(indexPath.row)")
//        
//    }
//    
//    // FAVE PRESSED *********************************
//    func FavePressed(sender: UIButton) {
//        let buttonRow = sender.tag
//        
//        if (sender.imageForState(UIControlState.Normal) == UIImage(named: "favourite")) {
//            sender.setImage(UIImage(named: "unfavourite"), forState: UIControlState.Normal)
//        } else {
//            sender.setImage(UIImage(named: "favourite"), forState: UIControlState.Normal)
//        }
//        println(buttonRow)
//    }
//    
//    func sideBarDidSelectButtonAtIndex(index: Int) {
//        if index == 0{
//            performSegueWithIdentifier("toDashboard", sender: self)
//        } else if index == 1 {
//            println("second")
//            sideBar.showSideBar(false)
//        } else if index == 2{
//            println("third")
//        } else if index == 3 {
//            println("fourth")
//            performSegueWithIdentifier("toSettings", sender: self)
//        } else if index == 4 {
//            exit(0)
//        }
//    }
//    
//    @IBAction func showMenu(sender: AnyObject) {
//        if sideBar.isSideBarOpen == true {
//            sideBar.showSideBar(false)
//        }else{
//            sideBar.showSideBar(true)
//        }
//    }
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        var staffTVController = segue.destinationViewController as StaffTableViewController
//        
//        staffTVController.staffID = tableView!.indexPathForSelectedRow()!.row
//        
//        
//    }
//    
//    
//}
