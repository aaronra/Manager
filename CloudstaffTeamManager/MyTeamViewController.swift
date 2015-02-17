//
//  MyTeamViewController.swift
//  CloudstaffTeamManager
//
//  Created by RitcheldaV on 11/2/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit

class MyTeamViewController: UIViewController, SideBarDelegate, UITableViewDelegate {

    @IBOutlet weak var dept: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var sideBar:SideBar = SideBar()
    
    var imageCache = [String : UIImage]()
    var arrayOfStaffs: [String] = ["http://cloudstaff.com/staff/ChristoperC.jpg","http://cloudstaff.com/staff/OscarG.jpg","","http://cloudstaff.com/staff/RicheldaV.jpg","http://cloudstaff.com/staff/ArnelN.jpg","http://cloudstaff.com/staff/RenzS.jpg","http://cloudstaff.com/staff/ElvinD.jpg"]
    var arrayOfStatus: [String] = ["onlinelist","offlinelist","onlinelist","onlinelist","offlinelist","onlinelist","onlinelist"]
    var arrayOfName: [String] = ["ChristoperC","OscarG","RonnielP","RitcheldaV","ArnelN","RenzS","ElvinD"]
    var arrayOfFullName: [String] = ["Christoper Castillo","Oscar Gonzales","Ronniel Pelayo","Ritchelda Venzon","Arnel Nuqui","Renz Sese","Elvin Dela Cruz"]
    var arrayOfIds: [Int] = [1,2,3,4,5,6,7]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideBar = SideBar(sourceView: self.view, menuItems:
            ["dashboard",
                "my team",
                "ping",
                "settings",
                "log out"])
        sideBar.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayOfStaffs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: MyTeamCell = tableView.dequeueReusableCellWithIdentifier("teamCell") as MyTeamCell
        
        cell.imgStatus.image = UIImage(named: arrayOfStatus[indexPath.row])
        
        cell.imgStaff?.image = UIImage(named: "staff")
        
       
        let urlString = arrayOfStaffs[indexPath.row]
        
        
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
        
        cell.Name.text = arrayOfName[indexPath.row]
        cell.fullName.text = arrayOfFullName[indexPath.row]
        
        cell.btnPing.tag = arrayOfIds[indexPath.row]
        cell.btnMail.tag = arrayOfIds[indexPath.row]
        cell.btnFave.tag = arrayOfIds[indexPath.row]
        
        cell.btnFave.addTarget(self, action: "FavePressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        cell.detailOne.text = "Shift"
        cell.detailTwo.text = "Team"
        cell.detailThree.text = "Position"
        cell.detailFour.text = "Status"
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("toStaffDetails", sender: self)
        
     
    }
    
    func FavePressed(sender: UIButton) {
        let buttonRow = sender.tag
        
        if (sender.imageForState(UIControlState.Normal) == UIImage(named: "favourite")) {
            sender.setImage(UIImage(named: "unfavourite"), forState: UIControlState.Normal)
        } else {
            sender.setImage(UIImage(named: "favourite"), forState: UIControlState.Normal)
        }
        println(buttonRow)
    }
    
    func sideBarDidSelectButtonAtIndex(index: Int)
    {
        if index == 0{
            performSegueWithIdentifier("toDashboard", sender: self)
        } else if index == 1 {
            println("second")
            sideBar.showSideBar(false)
        } else if index == 2{
            println("third")
        } else if index == 3 {
            println("fourth")
            performSegueWithIdentifier("toSettings", sender: self)
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var staffTVController : StaffTableViewController = segue.destinationViewController as StaffTableViewController
        var teamIndex = tableView!.indexPathForSelectedRow()!.row
        
        staffTVController.vLblName = arrayOfName[teamIndex]
        staffTVController.vLblFullName = arrayOfFullName[teamIndex]
        staffTVController.vImgStaff = arrayOfStaffs[teamIndex]
        staffTVController.vImgStatus = arrayOfStatus[teamIndex]
        staffTVController.vDetailOne = "Status"
        staffTVController.vDetailTwo = "Team"
        staffTVController.vDetailThree = "Position"
        staffTVController.vDetailFour = "Status"
        
    }
    
    
}
