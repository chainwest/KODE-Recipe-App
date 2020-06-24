//
//  SingleRecipe.swift
//  KODE Recipe App
//
//  Created by Evgeniy on 24.06.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import Foundation

struct RecipeBrief: Decodable {
    var uuid: String
    var name: String
}

struct Recipe: Decodable {
    var uuid: String
    var name: String
    var images: [String]
    var lastUpdated: Int
    var description: String
    var instructions: String
    var difficulty: Int
    var similar: [RecipeBrief]
}

struct RecipeResponse: Decodable {
    var response: Recipe
}
