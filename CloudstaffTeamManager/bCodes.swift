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
//            arrayOfIds.append(id)
//            arrayofStaffsImg.append(photo)
//            arrayofLogin.append(login + "list")
//            arrayofUsername.append(username)
//            arrayofName.append(name)
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
//        
//        cell.imgStatus.image = UIImage(named: arrayofLogin[indexPath.row])
//        
//        cell.imgStaff?.image = UIImage(named: "staff")
//        
//        
//        let urlString = arrayofStaffsImg[indexPath.row]
//        
//        
//        var image = self.imageCache[urlString]
//        
//        
//        if( image == nil ) {
//            // If the image does not exist, we need to download it
//            var imgURL: NSURL = NSURL(string: urlString)!
//            
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
//        
//        cell.btnFave.addTarget(self, action: "FavePressed:", forControlEvents: UIControlEvents.TouchUpInside)
//        
//        cell.detailOne.text = "Shift"
//        cell.detailTwo.text = "Team"
//        cell.detailThree.text = "Position"
//        cell.detailFour.text = "Status"
//        
//        return cell
//        
//    }
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        performSegueWithIdentifier("toStaffDetails", sender: self)
//        
//    }
//    
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
//        var staffTVController : StaffTableViewController = segue.destinationViewController as StaffTableViewController
//        var teamIndex = tableView!.indexPathForSelectedRow()!.row
//        
//        staffTVController.vLblName = arrayofUsername[teamIndex]
//        staffTVController.vLblFullName = arrayofName[teamIndex]
//        staffTVController.vImgStaff = arrayofStaffsImg[teamIndex]
//        staffTVController.vImgStatus = arrayofLogin[teamIndex]
//        staffTVController.vDetailOne = "Status"
//        staffTVController.vDetailTwo = "Team"
//        staffTVController.vDetailThree = "Position"
//        staffTVController.vDetailFour = "Status"
//        
//    }
//    
//    
//}
