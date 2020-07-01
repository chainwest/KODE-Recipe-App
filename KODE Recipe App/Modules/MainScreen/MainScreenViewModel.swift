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
    
    private(set) var recipeList = [RecipeListElement]()
    private(set) var filteredRecipeList = [RecipeListElement]()
    private var numberOfRows: Int = 0
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    //MARK: - Network methods
    
    func getRecipesList() {
        dependencies.apiService.getRecipesList { response in
            switch response {
            case .success(let data):
                self.recipeList = data.recipes
                self.filteredRecipeList = self.recipeList
                self.numberOfRows = self.recipeList.count
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
            updateRecipes()
            return
        }
        
        filteredRecipeList = recipeList.filter { recipe -> Bool in
            recipe.name.lowercased().contains(lowercasedInput) ||
            recipe.instructions.lowercased().contains(lowercasedInput) ||
            recipe.description!.lowercased().contains(lowercasedInput)
        }
        updateRecipes()
    }
    
    private func updateRecipes() {
        self.numberOfRows = filteredRecipeList.count
        onDidUpdate?()
    }
    
    //MARK: - Sort List
    
//    func sortByName() -> UIAlertAction {
//
//
//        return actionSortByName
//    }
//
//    func sortByDate() -> UIAlertAction {
//        let actionSortByDate = UIAlertAction(title: "By date", style: .default) { alert in
//            self.filteredRecipeList.sort { (first, second) -> Bool in
//                first.lastUpdated < second.lastUpdated
//            }
//            self.onDidUpdate?()
//        }
//
//        return actionSortByDate
//    }
    
    //MARK: - TableView methods
    
    func getNumberOfRows() -> Int {
        return numberOfRows
    }
    
    func didSelectRow(uuid: Int) {
        let uuid = recipeList[uuid].uuid
        delegate?.didRequestShowDetails(uuid: uuid)
    }
}
