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
    
    var id: Int = 0
    var name: String = ""
    var description: String = ""
    var thumbnail: MarvelThumbnail!
    var urls: [MarvelCharacterURL] = []
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        id              <- map["id"]
        name            <- map["name"]
        description     <- map["description"]
        thumbnail       <- map["thumbnail"]
        urls            <- map["urls"]
        
    }

}
