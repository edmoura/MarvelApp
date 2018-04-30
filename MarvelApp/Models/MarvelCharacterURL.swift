//
//  MarvelCharacterURL.swift
//  MarvelApp
//
//  Created by Edson iMAC on 28/04/2018.
//  Copyright © 2018 Edson Moura. All rights reserved.
//

import UIKit
import ObjectMapper

struct MarvelCharacterURL: Mappable {
    
    var type: String = ""
    var url: String = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        type    <- map["type"]
        url     <- map["url"]
        
    }

}
