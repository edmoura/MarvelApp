//
//  MarvelResponse.swift
//  MarvelApp
//
//  Created by Edson iMAC on 28/04/2018.
//  Copyright © 2018 Edson Moura. All rights reserved.
//

import Foundation

enum ResponseMarvelInfo {
    case success(model: MarvelInfo)
    case serverError(description: MarvelServerError)
    case timeOut(description: MarvelServerError)
    case noConnection(description: MarvelServerError)
}

enum ResponseMarvelCharacter {
    case success(model: [MarvelCharacter])
    case serverError(description: MarvelServerError)
    case timeOut(description: MarvelServerError)
    case noConnection(description: MarvelServerError)
}
