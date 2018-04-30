//
//  Whatsapp.swift
//  Send2Phone
//
//  Created by Sohel Siddique on 3/27/15.
//  Copyright (c) 2015 Zuzis. All rights reserved.
//

import UIKit

class WhatsAppActivity : UIActivity{
    
    override init() {
        self.text = ""
    }
    
    var text:String?

    func activityType()-> String {
        return NSStringFromClass(self.classForCoder)
    }
    
    func activityImage()-> UIImage
    {
        return UIImage(named: "whatsapp2")!;
    }
    
    func activityTitle() -> String
    {
        return "WhatsApp";
    }
    
    class func activityCategory() -> UIActivityCategory{
        return UIActivityCategory.share
    }
    
    func getURLFromMessage(message:String)-> NSURL
    {
        var url = "whatsapp://"
        
        if (message != "")
        {
            url = "\(url)send?text=\(message)"
        }
        
        return NSURL(string: url)!
    }
    
    func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
        for activityItem in activityItems
        {
            if (activityItem.isKind(of: NSString.self)){
                self.text = activityItem as? String;
                let whatsAppURL:NSURL  = self.getURLFromMessage(message: self.text!)
                return UIApplication.shared.canOpenURL(whatsAppURL as URL)
            }
        }
        return false;
    }
    
    func prepareWithActivityItems(activityItems: [AnyObject]) {
        for activityItem in activityItems{
            if (activityItem.isKind(of: NSString.self)){
                let whatsAppUrl:NSURL = self.getURLFromMessage(message: self.text!)
                if(UIApplication.shared.canOpenURL(whatsAppUrl as URL)){
                    UIApplication.shared.openURL(whatsAppUrl as URL)
                }
                break;
            }
        }
    }
}
