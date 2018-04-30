//
//  MockLoader.swift
//  MarvelAppTests
//
//  Created by Edson iMAC on 30/04/2018.
//  Copyright © 2018 Edson Moura. All rights reserved.
//

import Foundation
import ObjectMapper

struct MockLoader {
    
    let data: Data
    let json: String
    
    init?(file: String, withExtension fileExt: String = "json", in bundle:Bundle = Bundle.main) {
        guard let path = bundle.path(forResource: file, ofType: fileExt) else {
            return nil
        }
        let pathURL = URL(fileURLWithPath: path)
        do {
            data = try Data(contentsOf: pathURL, options: .dataReadingMapped)
            if let decoded = NSString(data: data, encoding: 0) as String? {
                json = decoded
            } else {
                return nil
            }
        } catch{
            return nil
        }
    }
    
}

extension MockLoader{
    func map<T: Mappable>(to type: T.Type) -> T? {
        return Mapper<T>().map(JSONString: json)
    }
}
