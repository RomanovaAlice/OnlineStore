//
//  DetailViewController.swift
//  OnlineStore
//
//  Created by Алиса Романова on 07.12.2022.
//

import iCarousel
import Combine

class DetailViewController: UIViewController {
    
    //MARK: - Properties
    
    private var data: PhoneModel!
    private let service = NetworkService()
    private var cancelable: Set<AnyCancellable> = []
    
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
    let addToCartButton = UIButton(backgroundColor: UIColor(named: "orange"), font: .systemFont(ofSize: 25, weight: .semibold), title: "Add to Cart", textColor: .white, radius: 10)
    
    private let shopButton = SegmentButton(title: "Shop")
    private let detailButton = SegmentButton(title: "Details")
    private let featuresButton = SegmentButton(title: "Features")
    private let minMemoryButton = UIButton(backgroundColor: UIColor(named: "orange"), textColor: .white, radius: 12)
    private let maxMemoryButton = UIButton(textColor: .gray)
    
    //imageViews
    let fiveStarsImageView = UIImageView(image: UIImage(named: "fiveStars"), tintColor: .systemGray2)
    let sdImageView = UIImageView(image: UIImage(systemName: "sdcard"), tintColor: .systemGray2)
    let ssdImageView = UIImageView(image: UIImage(systemName: "internaldrive"), tintColor: .systemGray2)
    let cameraImageView = UIImageView(image: UIImage(systemName: "camera"), tintColor: .systemGray2)
    let gpuImageView = UIImageView(image: UIImage(systemName: "squareshape.squareshape.dashed"), tintColor: .systemGray2)
    
    //views
    let carouselView = iCarousel()
    let productInformationView = UIView(backgroundColor: UIColor(named: "white"), radius: 35)
    
    //stackViews
    lazy var accessoryTitlesStackView = UIStackView(arrangedSubviews: [gpuLabel, cameraLabel, sdLabel, ssdLabel], spacing: 27, axis: .horizontal)
    lazy var segmentStackVeiw = UIStackView(arrangedSubviews: [shopButton, detailButton, featuresButton], spacing: 67, axis: .horizontal)
    lazy var memoryStackView = UIStackView(arrangedSubviews: [minMemoryButton, maxMemoryButton], spacing: 15, axis: .horizontal)
    
    //MARK: -viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargetsToButtons()
        
        service.getData(phoneModel: .phoneModel).sink { event in
            switch event {
                
            case .finished:
                self.setupNavigationBar()
                self.setShadows()
                self.setupCarousel()
                
                self.setData()
                
            case .failure(let error):
                print(error)
            }
        } receiveValue: { data in
            self.data = data
        }.store(in: &cancelable)

        setupConstraints()
    }
    
    private func setData() {
        phoneNameLabel.text = data.title
        gpuLabel.text = data.CPU
        cameraLabel.text = data.camera
        sdLabel.text = data.ssd
        ssdLabel.text = data.sd
        minMemoryButton.setTitle("\(data.capacity.first!) gb", for: .normal)
        maxMemoryButton.setTitle("\(data.capacity.last!) gb", for: .normal)
    }
    
    
    //MARK: - setupNavigationBar
    
    private func setupNavigationBar() {
        view.backgroundColor = UIColor(named: "gray")
        tabBarController?.tabBar.isHidden = true
        navigationItem.hidesBackButton = true
    }
    
    //
    
    private func addTargetsToButtons() {
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - setupNavigationBar
    
    private func setShadows() {
        productInformationView.layer.shadowColor = UIColor.systemGray.cgColor
        productInformationView.layer.shadowRadius = 8
        productInformationView.layer.shadowOpacity = 0.7
        productInformationView.layer.shadowOffset = CGSize(width: 5, height: 5)
    }
    
    //MARK: - setupCarousel
    
    private func setupCarousel() {
        carouselView.type = .rotary
        carouselView.dataSource = self
    }
}

//MARK: - iCarouselDataSource

extension DetailViewController: iCarouselDataSource {
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 3
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let cell = UIView(frame: CGRect(x: 0, y: 0, width: 220, height: 300))
        
        let image = UIImageView()
        image.center = cell.center
        cell.addSubview(image)
        view?.backgroundColor = .red
        image.load(url: data.images[index])
        
        cell.backgroundColor = .gray
        cell.layer.borderWidth = 1
        
        cell.layer.shadowColor = UIColor.systemGray3.cgColor
        cell.layer.shadowRadius = 5
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        
        cell.layer.cornerRadius = 20
        
        return cell
    }
}
