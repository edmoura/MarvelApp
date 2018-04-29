//
//  MarvelInfo.swift
//  MarvelApp
//
//  Created by Edson iMAC on 28/04/2018.
//  Copyright © 2018 Edson Moura. All rights reserved.
//

import UIKit
import ObjectMapper

struct MarvelInfo: Mappable {
    
    var code: Int
    var status: String
    var data: MarvelData
    
    init?(map: Map) {
        
        code    = (try? map.value("code")) ?? 0
        status  = (try? map.value("status")) ?? ""
        data    = (try? map.value("data")) ?? MarvelData(map: map)!
        
    }
    
    mutating func mapping(map: Map) {
        
        code    <- map["code"]
        status  <- map["status"]
        data    <- map["data"]
        
    }

}
