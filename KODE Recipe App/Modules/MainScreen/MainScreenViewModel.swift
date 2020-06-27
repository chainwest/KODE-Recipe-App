//
//  MainScreenViewModel.swift
//  KODE Recipe App
//
//  Created by Evgeniy on 24.06.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import Kingfisher

protocol MainScreenViewModelDelegate: class {
    func didRequestShowDetails()
}

class MainScreenViewModel {
    typealias Dependencies = HasApiService
    
    weak var delegate: MainScreenViewModelDelegate?
    
    let dependencies: Dependencies
    
    var onDidUpdate: (() -> Void)?
    
    private(set) var recipeList: [RecipeListElement]?
    private(set) var numberOfRows: Int = 0
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    //MARK: - Network methods
    
    func getRecipesList() {
        dependencies.apiService.getRecipesList { response in
            switch response {
            case .success(let data):
                self.recipeList = data.recipes
                self.numberOfRows = data.recipes.count
                self.onDidUpdate?()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getSingleRecipe() {
        //dependencies.apiService.getRecipe(uuid: <#T##String#>, completion: <#T##(Result<RecipeResponse, Error>) -> Void#>)
    }
    
    //MARK: - TableView methods
    
    func setupCell(cell: MainScreenTableViewCell, indexPath: IndexPath) {
        let imageURL = URL(string: (recipeList?[indexPath.row].images.first)!)
        
        cell.titleLabel.text = recipeList?[indexPath.row].name
        cell.descriptionLabel.text = recipeList?[indexPath.row].description
        //cell.dateLabel.text = String(recipeList?[indexPath.row].lastUpdated)
        cell.recipeImageView.kf.setImage(with: imageURL)
    }
    
    func getNumberOfRows() -> Int {
        return numberOfRows
    }
}