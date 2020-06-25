//
//  MainScreenCoordinator.swift
//  KODE Recipe App
//
//  Created by Evgeniy on 25.06.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit

class MainScreenCoordinator: Coordinator {
    let rootViewController: UINavigationController
    
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
        rootViewController.setViewControllers([mainScreenViewController], animated: false)
    }
}

extension MainScreenCoordinator: MainScreenViewModelDelegate {
    func didRequestShowDetails() {}
}
