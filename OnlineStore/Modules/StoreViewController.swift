//
//  StoreViewController.swift
//  OnlineStore
//
//  Created by Алиса Романова on 07.12.2022.
//

import UIKit
import Combine

class StoreViewController: UIViewController {
    
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
    }

    //MARK: - Properties
    
    private var cancelable: Set<AnyCancellable> = []
    private var storeCollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Store>!

    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "gray")
        
        setupCollectionView()
        setupDataSource()
        setupSnapshot()
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
        var snapshot = NSDiffableDataSourceSnapshot<Section, Store>()
        
        snapshot.appendSections([.selectCategory, .search, .hotSales, .bestSeller])
//        snapshot.appendItems(users, toSection: .users)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    //MARK: - setupDataSource
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Store>(collectionView: storeCollectionView, cellProvider: { [weak self] collectionView, indexPath, _ in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.selectCategoryCell.rawValue, for: indexPath) as! SelectCategoryCell
            
            return cell
        })
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in

            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Identifiers.sectionHeader.rawValue, for: indexPath) as? SectionHeader else {
                  fatalError("Can not create new section header") }

            sectionHeader.configure(text: "People nearly you", font: .systemFont(ofSize: 25))

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
        
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 10, bottom: 20, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.65))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 15, bottom: 10, trailing: 15)
        
        let sectionHeader = createSectionHeader()
          section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    //MARK: - createSearchSection

    private func createSearchSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 10, bottom: 20, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.65))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 15, bottom: 10, trailing: 15)
        
        let sectionHeader = createSectionHeader()
          section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    //MARK: - createHotSalesSection

    private func createHotSalesSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(1/2))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let sectionHeader = createSectionHeader()
          section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    //MARK: - createBestSellerSection

    private func createBestSellerSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                               heightDimension: .fractionalWidth(0.65))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 15, bottom: 10, trailing: 15)
        
        let sectionHeader = createSectionHeader()
          section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
     
     //MARK: - createSectionHeader
     
     private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {

         let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))

         let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
         
         return sectionHeader
     }

}

//MARK: - UICollectionViewDelegate

extension StoreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
