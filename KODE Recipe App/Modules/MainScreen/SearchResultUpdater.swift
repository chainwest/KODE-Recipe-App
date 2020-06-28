//
//  SearchResultUpdater.swift
//  KODE Recipe App
//
//  Created by Evgeniy on 28.06.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit

class SearchResultUpdater: NSObject, UISearchResultsUpdating {
    let viewModel: MainScreenViewModel
    
    init(viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchInput = searchController.searchBar.text else { return }
        
        viewModel.filterList(input: searchInput)
    }
}
