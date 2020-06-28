//
//  DetailsScreenViewModel.swift
//  KODE Recipe App
//
//  Created by Evgeniy on 28.06.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import Foundation

protocol DetailsScreenViewModelDelegate: class {
    func viewModelDelegateDidFinish()
}

class DetailsScreenViewModel {
    typealias Dependencies = HasApiService
    
    weak var delegate: DetailsScreenViewModelDelegate?
    var recipeResponse: Recipe?
    let dependencies: Dependencies
    let uuid: String
    
    var onDidUpdate: (() -> Void)?
    var onDidError: ((Error) -> Void)?
    
    init(dependencies: Dependencies, uuid: String) {
        self.dependencies = dependencies
        self.uuid = uuid
        getRecipe()
    }
    
    private func getRecipe() {
        dependencies.apiService.getRecipe(uuid: uuid) { response in
            switch response {
            case .success(let data):
                self.recipeResponse = data.response
            case .failure(let error):
                print(error)
            }
        }
    }
}
