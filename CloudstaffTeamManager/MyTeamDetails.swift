//
//  MyTeamDetails.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 2/4/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import Foundation

struct StaffImages {
    var idstaff : Int
    var imgstaff : String
    
    init(idstaff: Int, imgstaff: String) {
        self.idstaff = idstaff
        self.imgstaff = imgstaff
    }
    
}


struct StaffMetrics {
    
    
}



class MyTeamDetails {
    
    
    // Function for Inserting Images in CollectionView
    class func staffImagesJSON(imageResults: NSArray) -> [StaffImages] {
        
        var staffImages = [StaffImages]()
        if imageResults.count > 0 {
            for images in imageResults {
                var staffID = images["id"] as? Int
                let imageURL = images["photo"] as? String ?? ""
                
                println("****************** \(imageURL)")
            }
            
        }
        return staffImages
    }
    
}
