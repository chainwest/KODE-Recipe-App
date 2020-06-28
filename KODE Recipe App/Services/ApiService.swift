//
//  ApiService.swift
//  KODE Recipe App
//
//  Created by Evgeniy on 24.06.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import Alamofire

struct RecipeResponse: Decodable {
    var response: Recipe
}

struct RecipesListResponse: Decodable {
    var recipes: [RecipeListElement]
}

protocol HasApiService {
    var apiService: ApiService { get }
}

class ApiService {
    private func baseRequest<T>(url: String, method: HTTPMethod, params: Parameters? = nil,
                                completion: @escaping (Swift.Result<T, Error>) -> Void) where T: Decodable {
        AF.request(url, method: method, parameters: params).responseData { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                
                do {
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(Swift.Result.success(decodedData))
                } catch let error {
                    completion(Swift.Result.failure(error))
                }
            case .failure(let error):
                completion(Swift.Result.failure(error))
            }
        }
    }
    
    func getRecipesList(completion: @escaping (Swift.Result<RecipesListResponse, Error>) -> Void) {
        baseRequest(url: Constants.baseURL + "recipes", method: .get) { response in
            completion(response)
        }
    }
    
    func getRecipe(uuid: String, completion: @escaping (Swift.Result<RecipeResponse, Error>) -> Void) {
        baseRequest(url: Constants.baseURL + "recipes/" + uuid, method: .get) { response in
            completion(response)
        }
    }
}
