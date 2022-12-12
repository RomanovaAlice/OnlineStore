//
//  DetailViewController.swift
//  OnlineStore
//
//  Created by Алиса Романова on 07.12.2022.
//

import iCarousel
import SnapKit
import Combine

class DetailViewController: UIViewController {
    
    //MARK: - Properties
    
    private var data: PhoneModel!
    private let service = NetworkService()
    private var cancelable: Set<AnyCancellable> = []
    
    //labels
    private let titleLabel = UILabel(text: "Product Details")
    private let phoneNameLabel = UILabel()
    private let selectColorAndCapacityLabel = UILabel(text: "Select color and capacity")
    private let sdLabel = UILabel()
    private let cameraLabel = UILabel()
    private let gpuLabel = UILabel()
    private let ssdLabel = UILabel()
    
    //buttons
    private let backButton = UIButton(backgroundColor: UIColor(named: "blue"), titntColor: .white, image: UIImage(systemName: "chevron.backward"), radius: 10)
    private let cartButton = UIButton(backgroundColor: UIColor(named: "orange"), titntColor: .white, image: UIImage(systemName: "bag"), radius: 10)
    private let favoriteButton = UIButton(backgroundColor: UIColor(named: "blue"), titntColor: .white, image: UIImage(systemName: "suit.heart"), radius: 10)
    private let shopButton = UIButton()
    private let detailButton = UIButton()
    private let featuresButton = UIButton()
    private let minMemoryButton = UIButton(backgroundColor: UIColor(named: "orange"), textColor: .white, radius: 10)
    private let maxMemoryButton = UIButton()
    private let brownColorButton = UIButton(titntColor: .white)
    private let blueColorButton = UIButton(titntColor: .white)
    private lazy var addToCartButton = UIButton()
    
    //imageViews
    private let fiveStarsImageView = UIImageView(image: UIImage(named: "fiveStars"))
    private let sdImageView = UIImageView(image: UIImage(named: "sd"), tintColor: .systemGray)
    private let ssdImageView = UIImageView(image: UIImage(named: "ssd"), tintColor: .systemGray)
    private let cameraImageView = UIImageView(image: UIImage(named: "camera"), tintColor: .systemGray)
    private let gpuImageView = UIImageView(image: UIImage(named: "gpu"), tintColor: .systemGray)
    
    //views
    private let carouselView = iCarousel()
    private let productInformationView = UIView(backgroundColor: UIColor(named: "white"), radius: 35)

    //contentViews
    private lazy var gpuContentView = UIView(imageView: gpuImageView, label: gpuLabel)
    private lazy var cameraContentView = UIView(imageView: cameraImageView, label: cameraLabel)
    private lazy var sdContentView = UIView(imageView: sdImageView, label: sdLabel)
    private lazy var ssdContentView = UIView(imageView: ssdImageView, label: ssdLabel)
    
    //stackViews
    private lazy var accessoriesStackVeiw = UIStackView(arrangedSubviews: [gpuContentView, cameraContentView, sdContentView, ssdContentView])
    private lazy var segmentStackVeiw = UIStackView(arrangedSubviews: [shopButton, detailButton, featuresButton])
    private lazy var colorsStackVeiw = UIStackView(arrangedSubviews: [brownColorButton, blueColorButton])
    private lazy var memoryStackView = UIStackView(arrangedSubviews: [minMemoryButton, maxMemoryButton])
    private lazy var colorsAndMemoryStackView = UIStackView(arrangedSubviews: [colorsStackVeiw, memoryStackView])
    private lazy var selectColorAndCapacityStackView = UIStackView(arrangedSubviews: [selectColorAndCapacityLabel, colorsAndMemoryStackView])
    
    private lazy var generalStackView = UIStackView(arrangedSubviews: [segmentStackVeiw, accessoriesStackVeiw, selectColorAndCapacityStackView, addToCartButton])
    
    //MARK: -viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        sdLabel.text = data.sd
        ssdLabel.text = data.ssd
        minMemoryButton.setTitle(data.capacity.first, for: .normal)
        maxMemoryButton.setTitle(data.capacity.last, for: .normal)
    }
    
    
    //MARK: - setupNavigationBar
    
    private func setupNavigationBar() {
        view.backgroundColor = UIColor(named: "gray")
        tabBarController?.tabBar.isHidden = true
        navigationItem.hidesBackButton = true
    }
    
    //MARK: - setupNavigationBar
    
    private func setShadows() {
        productInformationView.layer.shadowColor = UIColor.systemGray.cgColor
        productInformationView.layer.shadowRadius = 5
        productInformationView.layer.shadowOpacity = 1
        productInformationView.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
    }
    
    //MARK: - setupCarousel
    
    private func setupCarousel() {
        carouselView.type = .rotary
        carouselView.dataSource = self
    }
    

}

//MARK: - Setup constraints

extension DetailViewController {
    private func setupConstraints() {
        
        //backButton
        
        view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(42)
            make.top.equalToSuperview().inset(79)
            make.height.width.equalTo(37)
        }
        
        //titleLabel
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.left.equalTo(backButton.snp.right).offset(51)
        }
        
        //cartButton
        
        view.addSubview(cartButton)
        
        cartButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(79)
            make.right.equalToSuperview().inset(35)
            make.width.height.equalTo(37)
        }
        
        //carouselView
        
        view.addSubview(carouselView)
        
        carouselView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(130)
            make.height.equalTo(350)
        }
        
        //productInformationView
        
        view.addSubview(productInformationView)
        
        productInformationView.snp.makeConstraints { make in
            make.top.equalTo(carouselView.snp.bottom).offset(7)
            make.left.right.bottom.equalToSuperview()
        }
        
        //favoriteButton
        
        productInformationView.addSubview(favoriteButton)
        
        favoriteButton.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.right.equalToSuperview().inset(37)
            make.top.equalToSuperview().inset(28)
        }
        
        //phoneNameLabel
        
        productInformationView.addSubview(phoneNameLabel)
        
        phoneNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(38)
            make.top.equalToSuperview().inset(28)
        }
        
        //fiveStarsImageView

        view.addSubview(fiveStarsImageView)

        fiveStarsImageView.snp.makeConstraints { make in
            make.top.equalTo(phoneNameLabel.snp.bottom).offset(7)
            make.left.equalToSuperview().inset(38)
            make.height.equalTo(23)
            make.width.equalTo(80)
        }
        
        //generalStackView
        
        productInformationView.addSubview(generalStackView)
        
        generalStackView.snp.makeConstraints { make in
            make.height.equalTo(250)
            make.left.right.equalToSuperview().inset(40)
            make.bottom.equalToSuperview().inset(58)
        }
    }
}

//MARK: - iCarouselDataSource

extension DetailViewController: iCarouselDataSource {
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 3
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let cell = UIView(frame: CGRect(x: 0, y: 0, width: 220, height: 330))
        
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
