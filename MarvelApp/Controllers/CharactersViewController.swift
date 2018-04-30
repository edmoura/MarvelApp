//
//  CharactersViewController.swift
//  MarvelApp
//
//  Created by Edson iMAC on 28/04/2018.
//  Copyright © 2018 Edson Moura. All rights reserved.
//

import UIKit
import EZYGradientView

class CharactersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoLoadingCharacters: UIView!
    @IBOutlet weak var infoLoadingCharConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var stackViewHeroes: UIStackView!
    @IBOutlet weak var imgLaunchScreen: UIImageView!
    @IBOutlet weak var stackLaunchScreen: UIStackView!
    
    let fetchCharacter = MarvelAPIRequest()
    var characters: [MarvelCharacter] = []
    var isLoadingCharacters = false
    var once = false
    var isLandscape = true
    var currentPage = 0
    var total = 0
    var characterSearch = ""
    var gradientView:EZYGradientView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 110
        tableView.rowHeight = UITableViewAutomaticDimension

        setupSearchBar()
        fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    private func setupSearchBar() {
        searchBar.tintColor = UIColor.white
        
        let searchTextField: UITextField? = searchBar.value(forKey: "searchField") as? UITextField
        if searchTextField!.responds(to: #selector(getter: UITextField.attributedPlaceholder)) {
            let attributeDict = [NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.8)]
            searchTextField!.attributedPlaceholder = NSAttributedString(string: "Search your heroes...", attributes: attributeDict)
        }
    }
    
    private func fetchData() {
        isLoadingCharacters = true
        fetchCharacter.load(name: characterSearch, index: currentPage) { (response) in
            switch response{
                
            case .success(let model):
                
                if !self.once {
                    self.hideFakeLaunchScreen()
                    self.once = true
                }
                
                self.total = model.data.total
                self.characters.append(contentsOf: model.data.results)
                self.tableView.reloadData()
                self.isLoadingCharacters = false
                self.hideLoadingMoreCharacters()
                self.hideLoadingHeroes()
                
                /*print("success")
                 print("total: \(self.total)")
                 print("characters: \(self.characters.count)")*/
                
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
        currentPage = 0
        characters = []
        tableView.reloadData()
        characterSearch = ""
        fetchData()
        showLoadingHeroes()
    }
    
    private func hideFakeLaunchScreen(){
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.imgLaunchScreen.alpha = 0
            self.stackLaunchScreen.alpha = 0
        }) { (success) in
            
        }
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
    
    private func showLoadingHeroes() {
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.stackViewHeroes.alpha = 1
        }) { (success) in
            
        }
    }
    
    private func hideLoadingHeroes() {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.stackViewHeroes.alpha = 0
        }) { (success) in
            
        }
    }
    
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        resignFirstResponder()
        if let search = searchBar.text {
            characters = [];
            tableView.reloadData()
            currentPage = 0;
            characterSearch = search
            fetchData()
            view.endEditing(true)
            showLoadingHeroes()
        }
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        disposeData()
        searchBar.text = ""
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "characterDetailsViewController") as? CharacterDetailsViewController {
            
            viewController.characterChoose = self.characters[indexPath.row]
            viewController.isLandscape = self.isLandscape
            view.endEditing(true)
            
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
