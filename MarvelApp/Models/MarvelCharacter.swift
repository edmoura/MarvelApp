//
//  MarvelCharacter.swift
//  MarvelApp
//
//  Created by Edson iMAC on 28/04/2018.
//  Copyright © 2018 Edson Moura. All rights reserved.
//

import UIKit
import ObjectMapper

struct MarvelCharacter: Mappable {
    
    var id: Int
    var name: String
    var description: String
    var thumbnail: MarvelThumbnail
    var urls: [MarvelCharacterURL]
    
    init?(map: Map) {
        
        id              = (try? map.value("id")) ?? 0
        name            = (try? map.value("name")) ?? ""
        description     = (try? map.value("description")) ?? ""
        thumbnail       = (try? map.value("thumbnail")) ?? MarvelThumbnail(map: map)!
        urls            = [(try? map.value("urls")) ?? MarvelCharacterURL(map: map)!]
        
    }
    
    mutating func mapping(map: Map) {
        
        id              <- map["id"]
        name            <- map["name"]
        description     <- map["description"]
        thumbnail       <- map["thumbnail"]
        urls            <- map["urls"]
        
    }

}
