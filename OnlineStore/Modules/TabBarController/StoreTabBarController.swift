//
//  StoreTabBarController.swift
//  OnlineStore
//
//  Created by Алиса Романова on 07.12.2022.
//

import SnapKit

final class StoreTabBarController: UITabBarController {
    
    //MARK: - Properties
    
    //viewControllers
    let storeViewController = UINavigationController(rootViewController: StoreViewController())
    let favoritesViewController = UIViewController()
    let profileViewController = UIViewController()
    let cartViewController = CartViewController()
    
    //other
    let circleImageView = UIImageView(image: UIImage(systemName: "circle.fill"))
    let explorerLabel = UILabel(text: "Explorer", font: .systemFont(ofSize: 15, weight: .medium), textColor: .white)
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColors()
        setTabBarAppearance()
        setViewControllers()
        
        setupConstraints()
    }
    
    //MARK: - didSelect
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.image == UIImage(systemName: "bag") {
            tabBar.isHidden = true
        }
    }
    
    //MARK: - setViewControllers
    
    private func setViewControllers() {
        cartViewController.tabBarItem.image = UIImage(systemName: "bag")
        cartViewController.tabBarItem.badgeValue = "4"
        
        favoritesViewController.tabBarItem.image = UIImage(systemName: "heart")
        profileViewController.tabBarItem.image = UIImage(systemName: "person")
        
        viewControllers = [storeViewController, cartViewController, favoritesViewController, profileViewController]
    }
    
    //MARK: - setColors
    
    private func setColors() {
        tabBar.backgroundColor = .clear
        tabBar.tintColor = UIColor(named: "gray")
        tabBar.unselectedItemTintColor = UIColor(named: "gray")
    }
    
    //MARK: - setTabBarAppearance
    
    private func setTabBarAppearance() {
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = 1
        
        let positionOnX: CGFloat = 5
        let positionOnY: CGFloat = 14
        
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer ()
        let bezierPath = UIBezierPath(roundedRect: CGRect (x: positionOnX, y: tabBar.bounds.minY - positionOnY - 5, width: width, height: height), cornerRadius: 30)
        
        roundLayer.fillColor = UIColor(named: "blue")?.cgColor
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer (roundLayer, at: 0)
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
    }
}

//MARK: - Setup constraints

extension StoreTabBarController {
    private func setupConstraints() {
        
        //imageView

        tabBar.addSubview(circleImageView)
        
        circleImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(40)
            make.height.width.equalTo(10)
            make.top.equalToSuperview().inset(14)
        }
        
        //label
        
        tabBar.addSubview(explorerLabel)
        
        explorerLabel.snp.makeConstraints { make in
            make.left.equalTo(circleImageView.snp.right).offset(5)
            make.top.equalToSuperview().inset(10)
        }
    }
}
