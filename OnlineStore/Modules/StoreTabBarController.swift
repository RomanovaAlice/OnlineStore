//
//  StoreTabBarController.swift
//  OnlineStore
//
//  Created by Алиса Романова on 07.12.2022.
//

import UIKit

class StoreTabBarController: UITabBarController {
    
    let store = StoreViewController()
    let mockview1 = UIViewController()
    let cart = CartViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.backgroundColor = UIColor(named: "blue")
        self.tabBar.tintColor = UIColor(named: "white")
        setTabBarAppearance()
        
        viewControllers = [
            generateNavigationController(rootViewController: cart, image: UIImage(systemName: "bag")!),
            generateNavigationController(rootViewController: mockview1, image: UIImage(systemName: "heart")!),
            generateNavigationController(rootViewController: store, image: UIImage(systemName: "person")!)
        ]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, image: UIImage) -> UIViewController {
        
        let navigationViewCcontroller = UINavigationController(rootViewController: rootViewController)
        navigationViewCcontroller.tabBarItem.image = image
        return navigationViewCcontroller
    }
    
    private func setTabBarAppearance() {
        
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        let roundLayer = CAShapeLayer ()
        let bezierPath = UIBezierPath(roundedRect: CGRect (x: positionOnX, y: tabBar.bounds.minY - positionOnY, width: width, height: height), cornerRadius: height / 2)
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer (roundLayer, at: 0)
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
    }
}
