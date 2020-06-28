//
//  MainScreenViewModel.swift
//  KODE Recipe App
//
//  Created by Evgeniy on 24.06.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import Kingfisher

protocol MainScreenViewModelDelegate: class {
    func didRequestShowDetails(uuid: String)
}

class MainScreenViewModel {
    typealias Dependencies = HasApiService
    
    weak var delegate: MainScreenViewModelDelegate?
    let dependencies: Dependencies
    
    var onDidUpdate: (() -> Void)?
    var onDidError: ((Error) -> Void)?
    
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
                self.recipeList = data.recipes
                self.onDidUpdate?()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - List filtering
    
    func filterList(input: String) {
        
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
