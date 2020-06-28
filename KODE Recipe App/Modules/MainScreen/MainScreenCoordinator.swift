//
//  MainScreenCoordinator.swift
//  KODE Recipe App
//
//  Created by Evgeniy on 25.06.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit

class MainScreenCoordinator: Coordinator {
    private let rootViewController: UINavigationController
    private var searchResultsUpdater: SearchResultUpdater?
    
    var mainScreenViewModel: MainScreenViewModel = {
        let dependencies = AppDependency.makeDefault()
        let viewModel = MainScreenViewModel(dependencies: dependencies)
        return viewModel
    }()
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    override func start() {
        mainScreenViewModel.delegate = self
        let mainScreenViewController = MainScreenTableViewController(viewModel: mainScreenViewModel)
        setupSearchBar(viewController: mainScreenViewController)
        rootViewController.setViewControllers([mainScreenViewController], animated: false)
    }
    
    func setupSearchBar(viewController: UIViewController) {
        let searchBar = UISearchController(searchResultsController: nil)
        searchBar.searchResultsUpdater = searchResultsUpdater
        searchBar.obscuresBackgroundDuringPresentation = false
        viewController.navigationItem.searchController = searchBar
        viewController.navigationItem.hidesSearchBarWhenScrolling = true
    }
}

extension MainScreenCoordinator: MainScreenViewModelDelegate {
    func didRequestShowDetails(uuid: String) {
        
    }
}
