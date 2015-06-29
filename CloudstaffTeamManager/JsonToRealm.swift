//
//  JsonToRealm.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 2/19/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import Foundation
import Realm


class Metric: RLMObject {
    dynamic var title = ""
    dynamic var daily: Int = 0
    dynamic var weekly: Int = 0
    dynamic var value: Int = 0
    
}


class Working: RLMObject {
    dynamic var task = ""
    dynamic var date = ""
    
}

class Staff: RLMObject {
    dynamic var id: Int = 0
    dynamic var stf_id = ""
    dynamic var username = ""
    dynamic var name = ""
    dynamic var photo = ""
    dynamic var shift_start = ""
    dynamic var shift_end = ""
    dynamic var team = ""
    dynamic var position = ""
    dynamic var status = ""
    dynamic var favorite = ""
    dynamic var login = ""
    dynamic var metrics = RLMArray(objectClassName: Metric.className())
    dynamic var working = RLMArray(objectClassName: Working.className())
    
    override class func primaryKey() -> String! {
        return "id"
    }
}

public class JsonToRealm {
    
    
    class func postLogin(params : Dictionary<String, AnyObject!>, url : String, postCompleted : (code: Int, msg: String, sessionID: String, clientID: String) -> ()) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &err) as? NSDictionary
            
            var msg = "No message"
            
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr!.description)'")
                postCompleted(code: 500, msg: "Error", sessionID: "", clientID: "")
            }else {
                
                if let parseJSON = json {
                    if let code = parseJSON["code"] as? Int {
                        if let errorMsg = parseJSON["message"] as? String {
                            if let sesID = parseJSON["sessionID"] as? String {
                                if let cliID = parseJSON["clientID"] as? String {
                                    postCompleted(code: code, msg: errorMsg, sessionID: sesID, clientID: cliID)
                                }
                            }
                        }
                    }
                    
                }else {

                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                    postCompleted(code: 500, msg: "Error", sessionID: "", clientID: "")
                }
            }
            
        })
        task.resume()
    }
    
    
    class func fetchData(params : Dictionary<String, AnyObject!>, url : String) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &err) as? NSDictionary
            
            var msg = "No message"
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr!.description)'")
            }else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    if let code = parseJSON["code"] as? Int {
                        if let staffList = parseJSON["myTeam"] as? [NSDictionary] {
                            
                            let realm = RLMRealm.defaultRealm()
                            realm.beginWriteTransaction()
                            for staff in staffList {
                                Staff.createOrUpdateInDefaultRealmWithObject(staff)
                            }
                            realm.commitWriteTransaction()
                            println("PATH --->>> \(RLMRealm.defaultRealm().path)")
                            
                            println(staffList)
                        }
                    }
                    
                }else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                }
            }
            
        })
        
        task.resume()
        
    }
    
    
    
}
