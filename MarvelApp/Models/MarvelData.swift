//
//  MarvelData.swift
//  MarvelApp
//
//  Created by Edson iMAC on 28/04/2018.
//  Copyright © 2018 Edson Moura. All rights reserved.
//

import UIKit
import ObjectMapper

struct MarvelData: Mappable {
    
    var offset: Int = 0
    var limit: Int = 0
    var total: Int = 0
    var count: Int = 0
    var results: [MarvelCharacter] = []
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        offset      <- map["total_count"]
        limit       <- map["limit"]
        total       <- map["total"]
        count       <- map["count"]
        results     <- map["results"]
        
    }
    
}
