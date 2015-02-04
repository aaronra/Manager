//
//  APIController.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 2/4/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import Foundation

protocol APIControllerProtocol {
    func didReceiveAPIResults(results: NSDictionary)
}

class APIController {
    
    var delegate: APIControllerProtocol
    init(delegate: APIControllerProtocol) {
        self.delegate = delegate
    }
    
    func get(path: String) {
        
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            println("Task completed")
            if(error != nil) {
                // If there is an error in the web request, print it to the console
                println(error.localizedDescription)
            }
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            if(err != nil) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            let results: NSArray = jsonResult["myTeam"] as NSArray
            self.delegate.didReceiveAPIResults(jsonResult) // THIS IS THE NEW LINE!!
        })
        task.resume()
    }
    
    func getMyTeamInfo(searchTerm: String) {
        
        // The iTunes API wants multiple terms separated by + symbols, so replace spaces with + signs
        let itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        // Now escape anything else that isn't URL-friendly
        if let escapedSearchTerm = itunesSearchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
            let urlPath = "http://10.1.51.130/cakephp/ActivityLog/indextry.json"
            
            println("-------------------->>>>>>   \(urlPath)")
            
            get(urlPath)
        }
    }
    
    func getStaffInfo(staffId: Int) {
        //        get("https://itunes.apple.com/lookup?id=\(staffId)&entity=song")
    }
    
}
















