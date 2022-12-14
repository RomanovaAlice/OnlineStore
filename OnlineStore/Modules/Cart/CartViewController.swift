//
//  CartViewController.swift
//  OnlineStore
//
//  Created by Алиса Романова on 07.12.2022.
//

import UIKit
import Combine

fileprivate enum Section: Int, CaseIterable {
    case cart
}

final class CartViewController: UIViewController {
    
    private let viewModel = CartViewModel()
    
    //MARK: - Properties
    
    private var totalPriceDictionary = [IndexPath : Int]()
    private var amountOfElementsDictionary = [Int : Int]()
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    private var cancelable: Set<AnyCancellable> = []
    
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
    
    var cartCollectionView: UICollectionView!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "gray")
        
        setShadowsForContentView()
        addTargetsToButtons()
        bind()
    }
    
    //MARK: - Binding
    
    private func bind() {
        viewModel.$state.sink { state in
            guard state == .success else { return }
            
            self.setupCollectionView()
            self.setupDataSource()
            self.setupSnapshot()
            self.setupConstraints()
            
        }.store(in: &cancelable)
    }
    
    //MARK: - setupCollectionView
    
    private func setupCollectionView() {
        cartCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        cartCollectionView.backgroundColor = .clear
        cartCollectionView.showsVerticalScrollIndicator = false
        
        cartCollectionView.register(CartCell.self, forCellWithReuseIdentifier: Identifiers.cartCell.rawValue)
    }
    
    //MARK: - setShadowsForContentView
    
    private func setShadowsForContentView() {
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
    }
    
    //MARK: - addTargetsToButtons
    
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
        
        snapshot.appendSections([.cart])
        
        viewModel.$searchData.sink { data in
            snapshot.appendItems(data.basket, toSection: .cart)
        }.store(in: &cancelable)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    //MARK: - setupDataSource
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: cartCollectionView, cellProvider: { [unowned self] collectionView, indexPath, _ in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.cartCell.rawValue, for: indexPath) as! CartCell
            
            viewModel.$searchData.sink { data in
                
                cell.modelNameLabel.text = data.basket[indexPath.item].title
                cell.phoneImageView.load(url: data.basket[indexPath.item].images)
                cell.priseLabel.text = "$\(String(data.basket[indexPath.item].price)).00"
                
                cell.buyCounter.sink { newValue in
                    if self.totalPriceDictionary.keys.contains(indexPath) {
                        self.totalPriceDictionary.updateValue(newValue * data.basket[indexPath.row].price, forKey: indexPath)
                        self.amountOfElementsDictionary.updateValue(newValue, forKey: data.basket[indexPath.row].price)
                    } else {
                        self.totalPriceDictionary[indexPath] = newValue * data.basket[indexPath.row].price
                        self.amountOfElementsDictionary[data.basket[indexPath.row].price] = newValue
                    }
                    
                    var sumOfPrices = 0
                    var sumOfAmount = 0
              
                    for i in self.totalPriceDictionary.values {
                        sumOfPrices += i
                    }
                    
                    for i in self.amountOfElementsDictionary.values {
                        sumOfAmount += i
                    }
            
                    self.totalPriceLabel.text = "$\(sumOfPrices) us"
                    self.tabBarItem.badgeValue = "\(sumOfAmount)"
                    
                }.store(in: &self.cancelable)
            }.store(in: &cancelable)
            
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
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 22, leading: 0, bottom: 22, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.36))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 25, bottom: 0, trailing: 20)
        
        return section
    }
}
