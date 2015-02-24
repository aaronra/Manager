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
    
    override class func primaryKey() -> String! {
        return "id"
        
    }
}

public class JsonToRealm {
    
    class func parseData(){
        
        
        // CALL the API
        let urlAsString = "http://10.1.51.130/cakephp/ActivityLog/indextry.json"
        let url: NSURL  = NSURL(string: urlAsString)!
        let urlSession = NSURLSession.sharedSession()
        
        
        
        let jsonQuery = urlSession.dataTaskWithURL(url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                println(error.localizedDescription)
            }
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            if (err != nil) {
                println("JSON Error \(err!.localizedDescription)")
            }
            
            // INSERTING JSONOBJECTS ON REALM
            let realm = RLMRealm.defaultRealm()
            let staffList = jsonResult["myTeam"] as [NSDictionary]
            realm.beginWriteTransaction()
            for staff in staffList {
                Staff.createOrUpdateInDefaultRealmWithObject(staff)
            }
            
            realm.commitWriteTransaction()
            println("PATH --->>> \(RLMRealm.defaultRealm().path)")
            
            
        })
        jsonQuery.resume()
        
    }
}