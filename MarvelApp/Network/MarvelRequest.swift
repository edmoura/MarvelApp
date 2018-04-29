//
//  MarvelRequest.swift
//  MarvelApp
//
//  Created by Edson iMAC on 28/04/2018.
//  Copyright © 2018 Edson Moura. All rights reserved.
//

import Foundation
import Alamofire

class MarvelRequest {
    
    let alamofireManager: SessionManager = {
        let configurarion = URLSessionConfiguration.default
        configurarion.timeoutIntervalForRequest = 60000
        configurarion.timeoutIntervalForResource = 60000
        return SessionManager(configuration: configurarion)
    }()
    
}
