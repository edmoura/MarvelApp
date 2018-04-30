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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientView = EZYGradientView()
        gradientView.frame = view.bounds
        gradientView.firstColor = UIColor(red: 216 / 255, green: 37 / 255, blue: 47 / 255, alpha: 1.0)
        gradientView.secondColor = UIColor(red: 237 / 255, green: 33 / 255, blue: 124 / 255, alpha: 1.0)
        gradientView.angleº = 0
        gradientView.colorRatio = 0.5
        gradientView.fadeIntensity = 1
        view.insertSubview(gradientView, at: 0)
        
        if let hero = characterChoose {
            
            labelName.text = hero.name
            labelDescription.text = !hero.description.isEmpty ? hero.description : "--"
            
            if let url = URL(string: hero.thumbnail.getImageURL()){
                
                bigImg.kf.indicatorType = .activity
                bigImg.kf.setImage(with: url)
                
            } else {
                
                bigImg.image = UIImage(named: "marvelAvatar")
                
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
