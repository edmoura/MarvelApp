//
//  UIImage+colorImage.swift
//  MarvelApp
//
//  Created by Edson iMAC on 29/04/2018.
//  Copyright © 2018 Edson Moura. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let myCgImage = image?.cgImage else { return nil }
        self.init(cgImage: myCgImage)
    }
    
}
