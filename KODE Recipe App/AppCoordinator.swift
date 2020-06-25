//
//  AppCoordinator.swift
//  KODE Recipe App
//
//  Created by Evgeniy on 25.06.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow?
    
    lazy var rootViewController: UINavigationController = {
       return UINavigationController(rootViewController: UIViewController())
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        guard let window = window else { return }
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
