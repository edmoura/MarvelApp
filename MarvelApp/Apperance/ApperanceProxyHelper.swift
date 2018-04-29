//
//  ApperanceProxyHelper.swift
//  MarvelApp
//
//  Created by Edson iMAC on 28/04/2018.
//  Copyright © 2018 Edson Moura. All rights reserved.
//

import Foundation
import UIKit

struct ApperanceProxyHelper {
    
    static func customizeNavigationBar() {
        
        let navigationBarAppearace = UINavigationBar.appearance()
        let redImage = UIImage(color: ColorPalette.red)
        navigationBarAppearace.tintColor = ColorPalette.white
        navigationBarAppearace.barTintColor = UIColor(patternImage: redImage!)
        navigationBarAppearace.shadowImage = redImage

    }
    
}
