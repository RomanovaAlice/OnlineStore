//
//  DetailViewController.swift
//  OnlineStore
//
//  Created by Алиса Романова on 07.12.2022.
//

import Combine
import UIKit

fileprivate enum Section: Int, CaseIterable {
    case detail
}

class DetailViewController: UIViewController {
    
    private let viewModel = DetailViewModel()
    
    //MARK: - Properties
    
    private var cancelable: Set<AnyCancellable> = []
    var detailCollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    
    //flags
    private var favoriteButtonIsSelected = true
    private var shopButtonIsSelected = true
    private var detailButtonIsSelected = true
    private var featuresButtonIsSelected = true
    private var brownButtonIsSelected = true
    private var blueButtonIsSelected = true
    private var maxMemoryButtonIsSelected = true
    private var minMemoryButtonIsSelected = true
    
    //labels
    let titleLabel = UILabel(text: "Product Details")
    let phoneNameLabel = UILabel(font: .systemFont(ofSize: 24, weight: .medium))
    let selectColorAndCapacityLabel = UILabel(text: "Select color and capacity", font: .systemFont(ofSize: 16, weight: .semibold))
    private let sdLabel = UILabel(font: .systemFont(ofSize: 11, weight: .light), textColor: .systemGray, textAlignment: .center)
    private let cameraLabel = UILabel(font: .systemFont(ofSize: 11, weight: .light), textColor: .systemGray, textAlignment: .center)
    private let gpuLabel = UILabel(font: .systemFont(ofSize: 11, weight: .light), textColor: .systemGray, textAlignment: .center)
    private let ssdLabel = UILabel(font: .systemFont(ofSize: 11, weight: .light), textColor: .systemGray, textAlignment: .center)
    
    //buttons
    let backButton = UIButton(backgroundColor: UIColor(named: "blue"), titntColor: .white, image: UIImage(systemName: "chevron.backward"), radius: 10)
    let cartButton = UIButton(backgroundColor: UIColor(named: "orange"), titntColor: .white, image: UIImage(systemName: "bag"), radius: 10)
    let favoriteButton = UIButton(backgroundColor: UIColor(named: "blue"), titntColor: .white, image: UIImage(systemName: "suit.heart"), radius: 10)
    let brownColorButton = UIButton(backgroundColor: .brown, titntColor: .white, image: UIImage(systemName: "checkmark"), radius: 20)
    let blueColorButton = UIButton(backgroundColor: UIColor(named: "blue"), titntColor: .white, radius: 20)
    let addToCartButton = UIButton(backgroundColor: UIColor(named: "orange"), font: .systemFont(ofSize: 20, weight: .semibold), textColor: .white, radius: 10)
    let minMemoryButton = UIButton(backgroundColor: UIColor(named: "orange"), textColor: .white, radius: 11)
    let maxMemoryButton = UIButton(textColor: .gray, radius: 11)
    let shopButton = SegmentButton(title: "Shop")
    let detailButton = SegmentButton(title: "Details")
    let featuresButton = SegmentButton(title: "Features")
    
    //imageViews
    let fiveStarsImageView = UIImageView(image: UIImage(named: "fiveStars"), tintColor: .systemGray2)
    let sdImageView = UIImageView(image: UIImage(systemName: "sdcard"), tintColor: .systemGray2)
    let ssdImageView = UIImageView(image: UIImage(systemName: "internaldrive"), tintColor: .systemGray2)
    let cameraImageView = UIImageView(image: UIImage(systemName: "camera"), tintColor: .systemGray2)
    let gpuImageView = UIImageView(image: UIImage(systemName: "squareshape.squareshape.dashed"), tintColor: .systemGray2)
    
    //views
    let productInformationView = UIView(backgroundColor: UIColor(named: "white"), radius: 35)
    
    //stackViews
    lazy var accessoryTitlesStackView = UIStackView(arrangedSubviews: [gpuLabel, cameraLabel, sdLabel, ssdLabel], spacing: 27, axis: .horizontal)
    
    //MARK: -viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setShadowsForProductInformationView()
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
            self.setData()
            self.setupConstraints()
            
        }.store(in: &cancelable)
    }
    
    //MARK: - setData
    
    private func setData() {
        
        viewModel.$searchData.sink { data in
            self.phoneNameLabel.text = data.title
            self.gpuLabel.text = data.CPU
            self.cameraLabel.text = data.camera
            self.sdLabel.text = data.ssd
            self.ssdLabel.text = data.sd
            self.minMemoryButton.setTitle("\(data.capacity.first!) gb", for: .normal)
            self.maxMemoryButton.setTitle("\(data.capacity.last!) gb", for: .normal)
            self.addToCartButton.setTitle("Add to Cart           $\(data.price).00", for: .normal)
        }.store(in: &cancelable)
    }
    
    //MARK: - setupNavigationBar
    
    private func setupNavigationBar() {
        view.backgroundColor = UIColor(named: "gray")
        tabBarController?.tabBar.isHidden = true
        navigationItem.hidesBackButton = true
    }
    
    //MARK: - setupCollectionView
    
    private func setupCollectionView() {
        detailCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        detailCollectionView.backgroundColor = .clear
        detailCollectionView.showsVerticalScrollIndicator = false

        detailCollectionView.register(DetailCell.self, forCellWithReuseIdentifier: Identifiers.detailCell.rawValue)
    }
    
    //MARK: - setShadowsForProductInformationView
    
    private func setShadowsForProductInformationView() {
        productInformationView.layer.shadowColor = UIColor.systemGray.cgColor
        productInformationView.layer.shadowRadius = 8
        productInformationView.layer.shadowOpacity = 0.7
        productInformationView.layer.shadowOffset = CGSize(width: 5, height: 5)
    }
    
    //MARK: - addTargetsToButtons
    
    private func addTargetsToButtons() {
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        shopButton.addTarget(self, action: #selector(shopButtonButtonTapped), for: .touchUpInside)
        detailButton.addTarget(self, action: #selector(detailButtonTapped), for: .touchUpInside)
        featuresButton.addTarget(self, action: #selector(featuresButtonTapped), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        brownColorButton.addTarget(self, action: #selector(brownButtonTapped), for: .touchUpInside)
        blueColorButton.addTarget(self, action: #selector(blueButtonTapped), for: .touchUpInside)
        maxMemoryButton.addTarget(self, action: #selector(maxMemoryButtonTapped), for: .touchUpInside)
        minMemoryButton.addTarget(self, action: #selector(minMemoryButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - @objc maxMemoryButtonTapped
    
    @objc private func maxMemoryButtonTapped() {
        if maxMemoryButtonIsSelected == true {
            maxMemoryButton.backgroundColor = UIColor(named: "orange")
            maxMemoryButton.setTitleColor(.white, for: .normal)
            
            minMemoryButton.backgroundColor = .clear
            minMemoryButton.setTitleColor(.gray, for: .normal)
            
            minMemoryButtonIsSelected = true
            maxMemoryButtonIsSelected = false
        }
    }
    
    //MARK: - @objc minMemoryButtonTapped
    
    @objc private func minMemoryButtonTapped() {
        if brownButtonIsSelected == true {
            minMemoryButton.backgroundColor = UIColor(named: "orange")
            minMemoryButton.setTitleColor(.white, for: .normal)
            
            maxMemoryButton.backgroundColor = .clear
            maxMemoryButton.setTitleColor(.gray, for: .normal)
            
            maxMemoryButtonIsSelected = true
            minMemoryButtonIsSelected = false
        }
    }
    
    //MARK: - @objc brownButtonTapped
    
    @objc private func brownButtonTapped() {
        if brownButtonIsSelected == true {
            brownColorButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            blueColorButton.setImage(UIImage(), for: .normal)
            
            blueButtonIsSelected = true
            brownButtonIsSelected = false
        }
    }
    
    //MARK: - @objc blueButtonTapped
    
    @objc private func blueButtonTapped() {
        if blueButtonIsSelected == true {
            blueColorButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            brownColorButton.setImage(UIImage(), for: .normal)
            
            blueButtonIsSelected = false
            brownButtonIsSelected = true
        }
    }
    
    //MARK: - @objc favoriteButtonTapped
    
    @objc private func favoriteButtonTapped() {
        favoriteButtonIsSelected = !favoriteButtonIsSelected
        
        if favoriteButtonIsSelected == true {
            favoriteButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    
    //MARK: - @objc shopButtonButtonTapped
    
    @objc private func shopButtonButtonTapped() {
        if shopButtonIsSelected == true {
            shopButton.setSelectedState()
            detailButton.setUnselectedState()
            featuresButton.setUnselectedState()
            
            detailButtonIsSelected = true
            featuresButtonIsSelected = true
            shopButtonIsSelected = false
        }
    }
    
    //MARK: - @objc detailButtonTapped
    
    @objc private func detailButtonTapped() {
        if detailButtonIsSelected == true {
            detailButton.setSelectedState()
            shopButton.setUnselectedState()
            featuresButton.setUnselectedState()
            
            shopButtonIsSelected = true
            featuresButtonIsSelected = true
            detailButtonIsSelected = false
        }
    }
    
    //MARK: - @objc featuresButtonTapped
    
    @objc private func featuresButtonTapped() {
        if featuresButtonIsSelected == true {
            featuresButton.setSelectedState()
            shopButton.setUnselectedState()
            detailButton.setUnselectedState()
            
            shopButtonIsSelected = true
            detailButtonIsSelected = true
            featuresButtonIsSelected = false
        }
    }
    
    //MARK: - @objc goBack
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - setupSnapshot

    private func setupSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        
        snapshot.appendSections([.detail])
        
        viewModel.$searchData.sink { data in
            snapshot.appendItems(data.images, toSection: .detail)
        }.store(in: &cancelable)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    //MARK: - setupDataSource

    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: detailCollectionView, cellProvider: { [unowned self] collectionView, indexPath, _ in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.detailCell.rawValue, for: indexPath) as! DetailCell
            
            viewModel.$searchData.sink { data in
                cell.imageView.load(url: data.images.first!)
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
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 40, bottom: 0, trailing: 40)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                               heightDimension: .fractionalWidth(0.75))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 20, leading: 20, bottom: 10, trailing: 60)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
}
