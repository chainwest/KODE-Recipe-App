//
//  MainScreenViewModel.swift
//  KODE Recipe App
//
//  Created by Evgeniy on 24.06.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import Kingfisher

protocol MainScreenViewModelDelegate {
    func didRequestShowDetails()
}

class MainScreenViewModel {
    typealias Dependencies = HasApiService
    
    let dependencies: Dependencies
    
    var onDidUpdate: (() -> Void)?
    
    private(set) var recipeList: RecipesListResponse?
    private(set) var numberOfRows: Int = 0
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    //MARK: - Network methods
    
    func getRecipesList() {
        dependencies.apiService.getRecipesList { response in
            switch response {
            case .success(let data):
                self.recipeList = data
                self.numberOfRows = data.response.count
                self.onDidUpdate?()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getSingleRecipe() {
        
    }
    
    //MARK: - TableView methods
    
    func setupCell(cell: UITableViewCell) {
        cell.textLabel?.text = recipeList?.response.first?.name
    }
    
    func getNumberOfRows() -> Int {
        return numberOfRows
    }
}
