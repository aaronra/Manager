//
//  JsonToRealm.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 2/19/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import Foundation
import Realm


class PingMessage: RLMObject {
    dynamic var ping = ""
    dynamic var message = ""
    //    dynamic var interval = NSTimer()
}

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
    

    class func post(params : Dictionary<String, String>, url : String, postCompleted : (loginStatus: String, msg: String) -> ()) {
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
                println("Error could not parse JSON: '\(jsonStr)'")
                postCompleted(loginStatus: "Failed", msg: "Error")
            }else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    if let loginStatus = parseJSON["status"] as? String {
                        if let errorMsg = parseJSON["error"] as? [String] {
                            for error in errorMsg {
                                println("loginStatus -->>> \(loginStatus) || errorMessage -->>> \(error)")
                                postCompleted(loginStatus: loginStatus, msg: error)
                            }
                        }
                        
                        // INSERTING JSONOBJECTS ON REALM
//                        let realm = RLMRealm.defaultRealm()
//                        
//                        let staffList = parseJSON["myTeam"] as [NSDictionary]
//                        println("--> \(staffList)")
//                        realm.beginWriteTransaction()
//                        
//                        for staff in staffList {
//                            Staff.createOrUpdateInDefaultRealmWithObject(staff)
//                        }
//                        
//                        let ping = PingMessage()
//                        ping.ping = "Sample Ping"
//                        realm.commitWriteTransaction()
//                        println("PATH --->>> \(RLMRealm.defaultRealm().path)")

                    }

                }else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                    postCompleted(loginStatus: "Failed", msg: "Error")
                }
            }
            
        })
        
        task.resume()
        
    }
    

}



