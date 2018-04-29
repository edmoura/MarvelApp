//
//  MarvelThumbnail.swift
//  MarvelApp
//
//  Created by Edson iMAC on 28/04/2018.
//  Copyright © 2018 Edson Moura. All rights reserved.
//

import UIKit
import ObjectMapper

struct MarvelThumbnail: Mappable {
    
    var path: String
    var ext: String
    
    init?(map: Map) {
        
        path    = (try? map.value("path")) ?? ""
        ext     = (try? map.value("extension")) ?? ""
        
    }
    
    mutating func mapping(map: Map) {
        
        path    <- map["path"]
        ext     <- map["extension"]
        
    }
    
    func getImageURL() -> String {
        
        return path + "." + ext
        
    }
    
}
