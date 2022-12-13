//
//  CartViewController.swift
//  OnlineStore
//
//  Created by Алиса Романова on 07.12.2022.
//

import SnapKit
import Combine

final class CartViewController: UIViewController {
    
    private enum Section: Int, CaseIterable {
        case cart
    }
    
    //MARK: - Properties
    
    //labels
    let titleLabel = UILabel(text: "My Cart", font: .systemFont(ofSize: 40, weight: .semibold))
    let totalLabel = UILabel(text: "Total", font: .systemFont(ofSize: 14, weight: .light), textColor: .white)
    let deliveryLabel = UILabel(text: "Delivery", font: .systemFont(ofSize: 14, weight: .light), textColor: .white)
    let totalPriceLabel = UILabel(text: "$6,000 us", font: .systemFont(ofSize: 14, weight: .bold), textColor: .white)
    let freeLabel = UILabel(text: "Free", font: .systemFont(ofSize: 14, weight: .bold), textColor: .white)
    let addAddressLabel = UILabel(text: "Add address", font: .systemFont(ofSize: 15, weight: .semibold))
    
    //buttons
    let checkuotButton = UIButton(backgroundColor: UIColor(named: "orange"), font: .systemFont(ofSize: 20, weight: .semibold), title: "Checkout", textColor: .white, radius: 15)
    let backButton = UIButton(backgroundColor: UIColor(named: "blue"), titntColor: .white, image: UIImage(systemName: "chevron.backward"), radius: 10)
    let locationButton = UIButton(backgroundColor: UIColor(named: "orange"), titntColor: .white, image: UIImage(systemName: "flag.fill"), radius: 10)
    
    //views
    let contentView = UIView(backgroundColor: UIColor(named: "blue"), radius: 35)
    let topSeparatorView = UIView(backgroundColor: .gray)
    let bottomSeparatorView = UIView(backgroundColor: .gray)
    
    //other
    var cartCollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    private var cancelable: Set<AnyCancellable> = []
    let isSelected = CurrentValueSubject<Bool, Never>.init(true)
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "gray")
        
        setShadows()
        setupCollectionView()
        setupSnapshot()
        setupDataSource()
        addTargetsToButtons()
        
        setupConstraints()
    }
    
    //MARK: - setShadows
    
    private func setShadows() {
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
    }
    
    //MARK: - setupCollectionView
    
    private func setupCollectionView() {
        cartCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        cartCollectionView.backgroundColor = .clear
        cartCollectionView.showsVerticalScrollIndicator = false

        cartCollectionView.register(CartCell.self, forCellWithReuseIdentifier: Identifiers.cartCell.rawValue)
    }
    
    //MARK: - setupCollectionView
    
    private func addTargetsToButtons() {
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
    
    //MARK: - @objc goBack
    
    @objc private func goBack() {
        tabBarController?.selectedIndex = 0
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - setupSnapshot

    private func setupSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()

        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    //MARK: - setupDataSource

    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: cartCollectionView, cellProvider: { [unowned self] collectionView, indexPath, _ in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.cartCell.rawValue, for: indexPath) as! CartCell
            
            return cell
        })
    }
    
    //MARK: - createCompositionalLayout
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(section: createSection())
        return layout
    }
        
    //MARK: - createSection

    private func createSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4),
                                               heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 15)
 
        
        return section
    }
}
