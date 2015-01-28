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
        
        let urlAsString = "http://api.androidhive.info/contacts/"
        let url: NSURL  = NSURL(string: urlAsString)!
        let urlSession = NSURLSession.sharedSession()
        
        var idArray: Array<String> = []
        var nameArray: Array<String> = []
        var emailArray: Array<String> = []
        var addressArray: Array<String> = []
        var genderArray: Array<String> = []
        
        
        
        let jsonQuery = urlSession.dataTaskWithURL(url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                println(error.localizedDescription)
            }
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            
            if (err != nil) {
                println("JSON Error \(err!.localizedDescription)")
            }
            
            let contactsArray = jsonResult["contacts"] as NSArray;
            for contacts : AnyObject in contactsArray{
                let conInfo = contacts as NSDictionary
                
                let id = conInfo["id"] as String
                let names = conInfo["name"] as String
                let email = conInfo["email"] as String
                let address = conInfo["address"] as String
                let gender = conInfo["gender"] as String
                
                idArray.append(id)
                nameArray.append(names)
                emailArray.append(email)
                addressArray.append(address)
                genderArray.append(gender)
            }
            

            println(nameArray)
            
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
