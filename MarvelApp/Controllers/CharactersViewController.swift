//
//  CharactersViewController.swift
//  MarvelApp
//
//  Created by Edson iMAC on 28/04/2018.
//  Copyright © 2018 Edson Moura. All rights reserved.
//

import UIKit
import EZYGradientView

class CharactersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoLoadingCharacters: UIView!
    @IBOutlet weak var infoLoadingCharConstraint: NSLayoutConstraint!
    
    let fetchCharacter = MarvelAPIRequest()
    var characters: [MarvelCharacter] = []
    var isLoadingCharacters = false
    var currentPage = 0
    var total = 0
    var characterChoose: MarvelCharacter? = nil
    var characterSearch = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 110
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let gradientView = EZYGradientView()
        gradientView.frame = view.bounds
        gradientView.firstColor = UIColor(red: 216 / 255, green: 37 / 255, blue: 47 / 255, alpha: 1.0)
        gradientView.secondColor = UIColor(red: 237 / 255, green: 33 / 255, blue: 124 / 255, alpha: 1.0)
        gradientView.angleº = 0
        gradientView.colorRatio = 0.5
        gradientView.fadeIntensity = 1
        view.insertSubview(gradientView, at: 0)
        
        fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func fetchData() {
        isLoadingCharacters = true
        fetchCharacter.load(name: characterSearch, index: currentPage) { (response) in
            switch response{
                
            case .success(let model):
                self.total = model.data.total
                self.characters.append(contentsOf: model.data.results)
                self.tableView.reloadData()
                self.isLoadingCharacters = false
                self.hideLoadingMoreCharacters()
                
            case .serverError(let description):
                print("Server error: \(description) \n")
                
            case .noConnection(let description):
                print("Server error noConnection: \(description) \n")
                
            case .timeOut(let description):
                print("Server error timeOut: \(description) \n")
                
            }
        }
    }
    
    private func disposeData(){
        characters = [];
        characterSearch = ""
        fetchData()
    }
    
    private func showLoadingMoreCharacters() {
        self.infoLoadingCharConstraint.constant = 0
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }) { (success) in
            
        }
    }
    
    private func hideLoadingMoreCharacters(){
        self.infoLoadingCharConstraint.constant = -50
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }) { (success) in
            
        }
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("hero: ", self.characters[indexPath.row])
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "characterDetailsViewController") as? CharacterDetailsViewController {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if indexPath.row == (characters.count - 1) && !isLoadingCharacters && characters.count != total {
            showLoadingMoreCharacters()
            currentPage += 1
            fetchData()
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "marvelCell") as! MarvelCharactersTableViewCell
        cell.fillCell(with: characters[indexPath.row])
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
}
