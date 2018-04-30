//
//  CharactersViewControllerTests.swift
//  MarvelAppTests
//
//  Created by Edson iMAC on 30/04/2018.
//  Copyright © 2018 Edson Moura. All rights reserved.
//

import Foundation
import Quick
import Nimble
import ObjectMapper
@testable import MarvelApp

class CharactersViewControllerTests: QuickSpec {
    override func spec() {
        describe("CharactersViewController") {
            
            var controller:CharactersViewController!
            //var apiMock:MarvelAPIRequest!
            
            beforeEach {
                let testBundle = Bundle(for: type(of: self))
                let mockLoader = MockLoader(file: "characters_response", in: testBundle)
                let model = Mapper<MarvelInfo>().map(JSONString:(mockLoader?.json)!)

                controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "charactersViewController") as? CharactersViewController
                controller.characters = (model?.data.results)!
                
                let _ = controller.view
            }
            
            it("should have expected props setup") {
                controller.viewDidLoad()
                expect(controller.characters).toNot(beNil())
                expect(controller.tableView).toNot(beNil())
                expect(controller.tableView.delegate).toNot(beNil())
                expect(controller.tableView.dataSource).toNot(beNil())
                expect(controller.searchBar).toNot(beNil())
            }
            
            it("should use mock response on fetchCharacters") {
                 controller.viewDidLoad()
                let count = controller.characters.count
                expect(count).toEventually(equal(2))
            }
            
            it("should be able to display content as tableView") {
                controller.viewDidLoad()
                controller.tableView.reloadData();
            }
            
            context("Empty search") {
                
                it("should not fetchCharacters when no searchTerm is provided") {
                    controller.searchBar.text = ""
                    let searchBar = controller.searchBar
                    controller.characters = []
                    controller.searchBarSearchButtonClicked(searchBar!)
                    expect(controller.characters.isEmpty).to(beTruthy())
                }
            }
            
            it("should hide keyboard with click on searchbar cancel button") {
                let searchBar = controller.searchBar!
                searchBar.becomeFirstResponder()
                controller.searchBarCancelButtonClicked(searchBar)
                expect(searchBar.isFirstResponder).to(beFalsy())
            }
            
            context("didSelectCharacter") {
                beforeEach {
                    let testBundle = Bundle(for: type(of: self))
                    let mockLoader = MockLoader(file: "characters_response", in: testBundle)
                    let model = Mapper<MarvelInfo>().map(JSONString:(mockLoader?.json)!)
                    
                    let navController: UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
                    
                    controller = navController.viewControllers.first as! CharactersViewController
                   controller.characters = (model?.data.results)!
                    let _ = controller.view
                    controller.viewDidLoad()
                }
                
                it("should navigate do next controller when selecting a character") {
                    let indexPath = IndexPath(row: 0, section: 0)
                    let controllerCounts =  controller.navigationController?.viewControllers.count
                    expect(controllerCounts).to(equal(1))
                    controller.tableView(controller.tableView, didSelectRowAt: indexPath)
                    expect(controller.navigationController?.viewControllers.count ?? 0).toEventually(equal(2), timeout: 3)
                }
            }
            
        }
    }
}
