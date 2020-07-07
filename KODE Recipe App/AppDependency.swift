//
//  AppDependency.swift
//  KODE Recipe App
//
//  Created by Evgeniy on 25.06.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import Foundation

protocol HasApiService {
    var apiService: ApiService { get }
}

class AppDependency: HasApiService {
    var apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    static func makeDefault() -> AppDependency {
        let apiService = ApiService()
        let appDependecy = AppDependency(apiService: apiService)
        
        return appDependecy
    }
}
