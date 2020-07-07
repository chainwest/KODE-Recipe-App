//
//  DetailsScreenCoordinator.swift
//  KODE Recipe App
//
//  Created by Evgeniy on 30.06.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit

protocol DetailsScreenCoordinatorDelegate: class {
    func didFinish(from coordinator: DetailsScreenCoordinator)
}

class DetailsScreenCoordinator: Coordinator {
    let uuid: String
    let rootViewController: UINavigationController
    
    weak var coordinatorDelegate: DetailsScreenCoordinatorDelegate?
    
    init(uuid: String, rootViewController: UINavigationController) {
        self.uuid = uuid
        self.rootViewController = rootViewController
    }
    
    override func start() {
        let dependencies = AppDependency.makeDefault()
        let viewModel = DetailsScreenViewModel(dependencies: dependencies, uuid: uuid)
        viewModel.delegate = self
        let viewController = DetailsScreenViewController(viewModel: viewModel)
        setupNavigationBar(viewController: viewController)
        rootViewController.pushViewController(viewController, animated: true)
    }
    
    private func setupNavigationBar(viewController: UIViewController) {
        viewController.navigationItem.title = "Details"
        viewController.navigationItem.largeTitleDisplayMode = .never
        rootViewController.navigationBar.tintColor = .black
    }
    
    override func finish() {
        coordinatorDelegate?.didFinish(from: self)
    }
}

extension DetailsScreenCoordinator: DetailsScreenViewModelDelegate {
    func viewModelDelegateDidFinish() {
        finish()
    }
}
