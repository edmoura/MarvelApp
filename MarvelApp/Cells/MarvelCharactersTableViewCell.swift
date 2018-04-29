//
//  MarvelCharactersTableViewCell.swift
//  MarvelApp
//
//  Created by Edson iMAC on 29/04/2018.
//  Copyright © 2018 Edson Moura. All rights reserved.
//

import UIKit
import Kingfisher

class MarvelCharactersTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var imgChar: UIImageView!
    @IBOutlet weak var labelChar: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        cellView.layer.cornerRadius = cellView.frame.size.width / 2
        cellView.layer.masksToBounds = true
        
        cellView.layer.borderWidth = 5
        cellView.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
        
        imgChar.image = UIImage(named: "marvelAvatar")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillCell(with character:MarvelCharacter){
        
        labelChar.text = character.name
        
        if let url = URL(string: character.thumbnail.getImageURL()){
            
            imgChar.kf.indicatorType = .activity
            imgChar.kf.setImage(with: url)
            
        } else {
            
            imgChar.image = UIImage(named: "marvelAvatar")
            
        }
        
    }

}
