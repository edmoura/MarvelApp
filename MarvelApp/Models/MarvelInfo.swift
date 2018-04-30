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
    
    var code: Int = 0
    var status: String = ""
    var data: MarvelData!
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        code    <- map["code"]
        status  <- map["status"]
        data    <- map["data"]
        
    }

}
