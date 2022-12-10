//
//  StoreViewController.swift
//  OnlineStore
//
//  Created by Алиса Романова on 07.12.2022.
//

import UIKit
import Combine

final class StoreViewController: UIViewController {
    
    let service = NetworkService()
    
    private enum Section: Int, CaseIterable {
        case selectCategory
        case search
        case hotSales
        case bestSeller
        
        func description() -> String {
            switch self {

            case .selectCategory:
                return "Select category"
            case .search:
                return ""
            case .hotSales:
                return "Hot sales"
            case .bestSeller:
                return "Best Seller"
            }
        }
        
        func showMore() -> String {
            switch self {
                
            case .selectCategory:
                return "view all"
            case .search:
                return ""
            case .hotSales:
                return "see more"
            case .bestSeller:
                return "see more"
            }
        }
    }

    //MARK: - Properties
    
    private var cancelable: Set<AnyCancellable> = []
    private var storeCollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    
    private let heartImage = CurrentValueSubject<UIImage, Never>.init(UIImage(systemName: "suit.heart")!)
    
    private var counter = 0
    
    var hotSalesArray: [HomeStore] = []
    var bestSellerArray: [BestSeller] = []
    var store: [Store] = []
    
    var currentIndexPath: IndexPath!
    
    var one: [AnyHashable] = [1,2,3,4]
    var two: [AnyHashable] = [9]
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "gray")
        
        service.getData(requestType: .store).sink { result in
            switch result {
                
            case .finished:
                
                self.setupCollectionView()
                self.setupDataSource()
                self.setupSnapshot()
                
            case .failure(let error):
                print(error)
            }
        } receiveValue: { data in
            self.hotSalesArray = data.home_store
            self.bestSellerArray = data.best_seller
        }.store(in: &cancelable)
    }
    
    //MARK: - setupCollectionView

   private func setupCollectionView() {
       storeCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
       storeCollectionView.backgroundColor = view.backgroundColor
       storeCollectionView.showsVerticalScrollIndicator = false
       storeCollectionView.delegate = self

       storeCollectionView.register(SelectCategoryCell.self, forCellWithReuseIdentifier: Identifiers.selectCategoryCell.rawValue)
       storeCollectionView.register(SearchCell.self, forCellWithReuseIdentifier: Identifiers.searchCell.rawValue)
       storeCollectionView.register(HotSalesCell.self, forCellWithReuseIdentifier: Identifiers.hotSalesCell.rawValue)
       storeCollectionView.register(BestSellerCell.self, forCellWithReuseIdentifier: Identifiers.bestSellerCell.rawValue)

       storeCollectionView.register(SectionHeader.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: Identifiers.sectionHeader.rawValue)

       view.addSubview(storeCollectionView)
   }

    //MARK: - setupSnapshot

    private func setupSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()

        snapshot.appendSections([.selectCategory, .search, .hotSales, .bestSeller])
        
        snapshot.appendItems(one, toSection: .selectCategory)
        snapshot.appendItems(two, toSection: .search)
        snapshot.appendItems(hotSalesArray, toSection: .hotSales)
        snapshot.appendItems(bestSellerArray, toSection: .bestSeller)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    //MARK: - setupDataSource

    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: storeCollectionView, cellProvider: {  collectionView, indexPath, _ in
            
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }
            
            switch section {
                
            case .selectCategory:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.selectCategoryCell.rawValue, for: indexPath) as! SelectCategoryCell
                
                let data = SelectedCategoryData()

                cell.imageView.image = data.images[indexPath.item]
                cell.titleLabel.text = data.titles[indexPath.item]

                return cell
                
            case .search:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.searchCell.rawValue, for: indexPath) as! SearchCell
                
                return cell
                
            case .hotSales:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.hotSalesCell.rawValue, for: indexPath) as! HotSalesCell
            
                if indexPath.item > 0 {
                    cell.newButton.isHidden = true
                }
                if indexPath.item == 1 {
                    cell.modelNameLabel.isHidden = true
                } else {
                    cell.modelNameLabel.text = self.hotSalesArray[indexPath.item].title
                    cell.subTitleLabel.text = self.hotSalesArray[indexPath.item].subtitle
                }

                cell.imageView.load(url: (self.hotSalesArray[indexPath.item].picture))
                
                return cell
                
            case .bestSeller:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.bestSellerCell.rawValue, for: indexPath) as! BestSellerCell

                cell.imageView.load(url: (self.bestSellerArray[indexPath.item].picture))
                cell.priseLabel.text = "$" + String(self.bestSellerArray[indexPath.item].price_without_discount)
                cell.discontLabel.attributedText = ("$" + String(self.bestSellerArray[indexPath.item].discount_price)).strikeThrough()
                cell.modelNameLabel.text = self.bestSellerArray[indexPath.item].title
                
                self.heartImage.sink { newImage in
                    
                    if indexPath == self.currentIndexPath {
                        cell.heartImageView.image = newImage
                    }
                  
                }.store(in: &self.cancelable)
                
                return cell
            }
        })

        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in

            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Identifiers.sectionHeader.rawValue, for: indexPath) as? SectionHeader else {
                  fatalError("Can not create new section header") }
            
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section kind") }

            sectionHeader.configure(text: section.description(), font: .systemFont(ofSize: 25, weight: .semibold), buttonTitle: section.showMore())
            
              return sectionHeader
          }
    }
    
    //MARK: - createCompositionalLayout
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            
            switch sectionKind {
                
            case .selectCategory:
                return self?.createSelectCategorySection()
            case .search:
                return self?.createSearchSection()
            case .hotSales:
                return self?.createHotSalesSection()
            case .bestSeller:
                return self?.createBestSellerSection()
            }
        }
        return layout
    }
    
    //MARK: - createSelectCategorySection

    private func createSelectCategorySection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4),
                                               heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 15)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let sectionHeader = createSectionHeader()
          section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    //MARK: - createSearchSection

    private func createSearchSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 20, bottom: 0, trailing: 15)
        
        return section
    }
    
    //MARK: - createHotSalesSection

    private func createHotSalesSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.97),
                                               heightDimension: .fractionalWidth(0.43))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 8, bottom: 0, trailing: 8)
        section.orthogonalScrollingBehavior = .continuous
        
        let sectionHeader = createSectionHeader()
          section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    //MARK: - createBestSellerSection

    private func createBestSellerSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 6, leading: 5, bottom: 6, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                               heightDimension: .fractionalWidth(0.65))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 5, leading: 14, bottom: 25, trailing: 14)
        
        let sectionHeader = createSectionHeader()
          section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
     
     //MARK: - createSectionHeader
     
     private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {

         let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))

         let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
         sectionHeader.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 8, bottom: 0, trailing: 0)
         
         return sectionHeader
     }
}

//MARK: - UICollectionViewDelegate

extension StoreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unknown section kind")
        }
        
        switch section {
            
        case .selectCategory:
            print("")
        case .search:
            print("")
        case .hotSales:
            print("")
        case .bestSeller:
            currentIndexPath = indexPath
            if counter % 2 == 0 {
                heartImage.send(UIImage(systemName: "heart.fill")!)
            } else {
                heartImage.send(UIImage(systemName: "suit.heart")!)
            }
            
            counter += 1
        }
    }
}