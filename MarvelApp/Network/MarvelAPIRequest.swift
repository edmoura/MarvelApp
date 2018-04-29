//
//  MarvelAPIRequest.swift
//  MarvelApp
//
//  Created by Edson iMAC on 28/04/2018.
//  Copyright © 2018 Edson Moura. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class MarvelAPIRequest: MarvelRequest {
    
    func load(name: String?, index: Int = 0, onComplete: @escaping(_ response:ResponseMarvelInfo) -> Void) {
        
        let offset = index * MarvelAPIConfig.limit
        
        var queryParams:[String:String] = ["offset":String(offset), "limit": String(MarvelAPIConfig.limit)]
        
        if let name = name, !name.isEmpty {
            queryParams["nameStartsWith"] = name.replacingOccurrences(of: " ", with: "")
        }
        
        let url = MarvelAPIConfig.bashURL + MarvelAPIConfig.pathCharacters + queryParams.queryString! + MarvelAPIConfig.getPermissions()

        Alamofire.request(url).responseJSON { (response) in
            let statusCode = response.response?.statusCode
            switch response.result{
            case .success(let value):
                let resultValue = value as? [String: Any]
                if statusCode == 200{
                    let model = Mapper<MarvelInfo>().map(JSONObject:resultValue)
                    onComplete(.success(model: model!))
                }
            case .failure(let error):
                let errorCode = error._code
                if errorCode == -1009 {
                    let erro = MarvelServerError(msgError: error.localizedDescription, statusCode: errorCode)
                    onComplete(.noConnection(description: erro))
                } else if errorCode == -1001 {
                    let erro = MarvelServerError(msgError: error.localizedDescription, statusCode: errorCode)
                    onComplete(.timeOut(description: erro))
                }
            }
        }
        
    }
    
}
