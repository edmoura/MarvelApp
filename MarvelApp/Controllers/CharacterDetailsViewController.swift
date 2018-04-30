//
//  CharacterDetailsViewController.swift
//  MarvelApp
//
//  Created by Edson iMAC on 29/04/2018.
//  Copyright © 2018 Edson Moura. All rights reserved.
//

import UIKit
import EZYGradientView

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet weak var bigImg: UIImageView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelName: UILabel!
    
    var characterChoose: MarvelCharacter? = nil
    var gradientView:EZYGradientView!
    var isLandscape = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelName.text = ""
        labelDescription.text = ""
        
        if let hero = characterChoose {
            
            labelName.text = hero.name
            labelDescription.text = !hero.description.isEmpty ? hero.description : ""
            
            if let url = URL(string: hero.thumbnail.getImageURL()){
                
                bigImg.kf.indicatorType = .activity
                bigImg.kf.setImage(with: url)
                
            } else {
                
                bigImg.image = UIImage(named: "marvelAvatar")
                
            }
            
        }
        
      self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .action, target: self, action:#selector(share(_:))), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        doGradient(angle: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.removeObserver(self, name:  NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    private func doGradient(angle:Float) {
        if gradientView != nil {
            if view.subviews.contains(gradientView) {
                gradientView.removeFromSuperview()
            }
        }
        
        gradientView = EZYGradientView()
        gradientView.frame = view.bounds
        gradientView.firstColor = UIColor(red: 216 / 255, green: 37 / 255, blue: 47 / 255, alpha: 1.0)
        gradientView.secondColor = UIColor(red: 237 / 255, green: 33 / 255, blue: 124 / 255, alpha: 1.0)
        gradientView.angleº = angle
        gradientView.colorRatio = 0.5
        gradientView.fadeIntensity = 1
        view.insertSubview(gradientView, at: 0)
    }
    
    @objc private func rotated() {
        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight:
            doGradient(angle: 0)
        default:
            doGradient(angle: 0)
        }
    }
    
    
    @objc func share(_ sender:UIBarButtonItem!)
    {
        let shareName = labelName.text
        let shareDescription = labelDescription.text
        
        let text = shareName! + "\n" + shareDescription!
        let url = URL(string: (characterChoose?.thumbnail.getImageURL())!)
        
        let shareItems:Array = [bigImg.image!, text, url!] as [Any]
        let wsActivity = WhatsAppActivity()
        let activityVC = UIActivityViewController(activityItems:shareItems, applicationActivities: [wsActivity])
        activityVC.popoverPresentationController?.sourceView = self.view
        present(activityVC, animated: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
