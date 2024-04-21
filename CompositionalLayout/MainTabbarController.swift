//
//  MainTabbarController.swift
//  CompositionalLayout
//
//  Created by Егоров Михаил on 08.05.2023.
//

import Foundation
import UIKit

class MainTabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let flowViewControllers = FlowViewController()
        let compositionalViewControllers = CompositionalViewController()
        let advancedViewControllers = AdvancedViewController()
        
        let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
        guard let convImage = UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: boldConfig) else { return }
        guard let peopleImage = UIImage(systemName: "person.2", withConfiguration: boldConfig) else { return }
        guard let carImage = UIImage(systemName: "car", withConfiguration: boldConfig) else { return }
        
        viewControllers = [
            generateNavigationController(rootViewController: advancedViewControllers, title: "Advanced", image: carImage),
            generateNavigationController(rootViewController: compositionalViewControllers, title: "compositiona", image: peopleImage),
            generateNavigationController(rootViewController: flowViewControllers, title: "Flow", image: convImage)
        ]
    }
    
    private func generateNavigationController(rootViewController:UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
    
}
