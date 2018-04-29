//
//  MarvelAPI.swift
//  MarvelApp
//
//  Created by Edson iMAC on 28/04/2018.
//  Copyright © 2018 Edson Moura. All rights reserved.
//

import UIKit
import CryptoSwift
import Keys

class MarvelAPIConfig {
    
    fileprivate static let keys = MarvelAppKeys()
    static let bashURL = "https://gateway.marvel.com/v1/public"
    static let pathCharacters = "/characters?"
    static let limit = 25;
    static let apikey = keys.marvelApiKey
    static let privatekey = keys.marvelPrivateKey
    
    static func getPermissions() -> String {
        
        let ts = Date().timeIntervalSince1970.description
        let hash = "\(ts)\(privatekey)\(apikey)".md5()
        let params = ["ts":ts, "apikey":apikey, "hash":hash]        
        return params.queryString!
        
    }
    
}
