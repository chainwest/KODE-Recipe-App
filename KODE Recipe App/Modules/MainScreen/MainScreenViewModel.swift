//
//  MainScreenViewModel.swift
//  KODE Recipe App
//
//  Created by Evgeniy on 24.06.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import Kingfisher
import UIKit

protocol MainScreenViewModelDelegate: class {
    func didRequestShowDetails(uuid: String)
}

class MainScreenViewModel {
    typealias Dependencies = HasApiService
    
    weak var delegate: MainScreenViewModelDelegate?
    let dependencies: Dependencies
    
    var onDidUpdate: (() -> Void)?
    
    private(set) var storedRecipeList = [RecipeListElement]()
    private(set) var recipeList = [RecipeListElement]()
    private var numberOfRows: Int {
        return recipeList.count
    }
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    //MARK: - Network methods
    
    func getRecipesList() {
        dependencies.apiService.getRecipesList { response in
            switch response {
            case .success(let data):
                self.storedRecipeList = data.recipes
                self.recipeList = data.recipes
                self.onDidUpdate?()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - List filtering
    
    func filterList(input: String) {
        let lowercasedInput = input.lowercased()
        
        guard !input.isEmpty else {
            updateRecipes(filteredRecipeList: storedRecipeList)
            return
        }
        
        let filteredRecipeList = recipeList.filter { recipe -> Bool in
            recipe.name.lowercased().contains(lowercasedInput) ||
            recipe.instructions.lowercased().contains(lowercasedInput) ||
            (recipe.description != nil && recipe.description!.lowercased().contains(lowercasedInput))
        }
        updateRecipes(filteredRecipeList: filteredRecipeList)
    }
    
    //MARK: - Help methods
    
    private func updateRecipes(filteredRecipeList: [RecipeListElement]) {
        recipeList = filteredRecipeList
        onDidUpdate?()
    }
    
    func restoreList() {
        recipeList = storedRecipeList
    }
    
    //MARK: - Sort List
    
    func sortByName() {
        recipeList.sort { first, second -> Bool in
            first.name < second.name
        }
        
        storedRecipeList.sort { first, second -> Bool in
            first.name < second.name
        }
        onDidUpdate?()
    }
    
    func sortByDate() {
        recipeList.sort { first, second -> Bool in
            first.lastUpdated < second.lastUpdated
        }
        
        storedRecipeList.sort { first, second -> Bool in
            first.lastUpdated < second.lastUpdated
        }
        onDidUpdate?()
    }
    
    //MARK: - TableView methods
    
    func getNumberOfRows() -> Int {
        return numberOfRows
    }
    
    func didSelectRow(uuid: Int) {
        let uuid = recipeList[uuid].uuid
        delegate?.didRequestShowDetails(uuid: uuid)
    }
}
