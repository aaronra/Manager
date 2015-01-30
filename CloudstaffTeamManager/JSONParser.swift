//
//  JSONParser.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 1/28/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import Foundation

let Tag = "JSONParser -->> "

public class JSONParser {
    
    
    class func getContactJSON() {
        
        let myid = "c2010"
        
        let urlAsString = "http://10.1.51.130/cakephp/ActivityLog/indextry.json"
        let url: NSURL  = NSURL(string: urlAsString)!
        let urlSession = NSURLSession.sharedSession()
        
        var idArray: Array<Int> = []
        var usernameArray: Array<String> = []
        var nameArray: Array<String> = []
        var photoArray: Array<String> = []
        var shtStartsArray: Array<String> = []
        var shtEndsArray: Array<String> = []
        var teamArray: Array<String> = []
        var positionArray: Array<String> = []
        var statusArray: Array<String> = []
        var favArray: Array<String> = []
        var loginArray: Array<String> = []

        
        let jsonQuery = urlSession.dataTaskWithURL(url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                println(error.localizedDescription)
            }
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            
            if (err != nil) {
                println("JSON Error \(err!.localizedDescription)")
            }
            
            let employeesArray = jsonResult["activitylogs"] as NSArray;
            for employee : AnyObject in employeesArray{
                let empInfo = employee as NSDictionary
                
                let id = empInfo["id"] as Int
                let usernames = empInfo["username"] as String
                let name = empInfo["name"] as String
                let photo = empInfo["photo"] as String
                let shift_start = empInfo["shift_start"] as String
                let shift_end = empInfo["shift_end"] as String
                let team = empInfo["team"] as String
                let position = empInfo["position"] as String
                let status = empInfo["status"] as String
                let favorite = empInfo["favorite"] as String
                let login = empInfo["login"] as String
                

                
                idArray.append(id)
                usernameArray.append(usernames)
                nameArray.append(name)
                photoArray.append(photo)
                shtStartsArray.append(shift_start)
                shtEndsArray.append(shift_end)
                teamArray.append(team)
                positionArray.append(position)
                statusArray.append(status)
                favArray.append(favorite)
                loginArray.append(login)

            }
            

            println(idArray)
            println(usernameArray)
            println(nameArray)
            println(photoArray)
            println(shtStartsArray)
            println(shtEndsArray)
            println(teamArray)
            println(positionArray)
            println(statusArray)
            println(favArray)
            println(loginArray)
            
//            if contains(idArray, myid) {
//                println("\(Tag)TRUE")
//                println(idArray)
//            }else {
//                println("\(Tag)FALSE")
//            }
            
        })
        jsonQuery.resume()
        
    }
    
}
