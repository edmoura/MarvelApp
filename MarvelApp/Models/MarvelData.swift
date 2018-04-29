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
    
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int
    var results: [MarvelCharacter]
    
    init?(map: Map) {
        
        offset      = (try? map.value("offset")) ?? 0
        limit       = (try? map.value("offset")) ?? 0
        total       = (try? map.value("offset")) ?? 0
        count       = (try? map.value("offset")) ?? 0
        results     = [(try? map.value("results")) ?? MarvelCharacter(map: map)!]
        
    }
    
    mutating func mapping(map: Map) {
        
        offset      <- map["total_count"]
        limit       <- map["limit"]
        total       <- map["total"]
        count       <- map["count"]
        results     <- map["results"]
        
    }
    
}
