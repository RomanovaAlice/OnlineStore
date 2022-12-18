//
//  BestSellerCell.swift
//  OnlineStore
//
//  Created by Алиса Романова on 08.12.2022.
//

import SnapKit

class BestSellerCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    //flags
    private var isFavorite = false
    
    //labels
    let priseLabel = UILabel(font: .systemFont(ofSize: 15, weight: .bold))
    let modelNameLabel = UILabel(font: .systemFont(ofSize: 10, weight: .light))
    let discontLabel = UILabel(font: .systemFont(ofSize: 8, weight: .thin), textColor: .systemGray)
    
    //buttons
    private let favoriteButton = UIButton(backgroundColor: UIColor(named: "white"), titntColor: UIColor(named: "orange"), image: UIImage(systemName: "suit.heart"))
    
    //imagesViews
    let imageView = UIImageView()
    
    //views
    let heartView = UIView(backgroundColor: .white, radius: 12.5)
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTargetsToButtons()
        setupSelfAppearens()
        setShadows()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupSelfAppearens() {
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor(named: "white")
        self.clipsToBounds = true
    }
    
    private func setShadows() {
        heartView.layer.shadowColor = UIColor.gray.cgColor
        heartView.layer.shadowRadius = 4
        heartView.layer.shadowOpacity = 0.2
        heartView.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
    }
    
    func addTargetsToButtons() {
        favoriteButton.addTarget(self, action: #selector(changeImage), for: .touchUpInside)
    }
    
    @objc private func changeImage() {
        isFavorite = !isFavorite
        
        if isFavorite {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        }
    }
}

//MARK: - Setup constraints

extension BestSellerCell {
    private func setupConstraints() {
        
        //imageView
        
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(168)
        }
        
        //priseLabel
        
        self.addSubview(priseLabel)
        
        priseLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(21)
            
        }
        
        //discontLabel
        
        self.addSubview(discontLabel)
        
        discontLabel.snp.makeConstraints { make in
            make.left.equalTo(priseLabel.snp.right).offset(7)
            make.bottom.equalTo(priseLabel).inset(2)
        }
        
        //modelNameLabel
        
        self.addSubview(modelNameLabel)
        
        modelNameLabel.snp.makeConstraints { make in
            make.top.equalTo(priseLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(21)
        }
        
        //heartView
        
        self.addSubview(heartView)
        
        heartView.snp.makeConstraints { make in
            make.right.top.equalToSuperview().inset(10)
            make.height.width.equalTo(25)
        }
        
        //favoriteButton
        
        heartView.addSubview(favoriteButton)
        
        favoriteButton.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.height.equalTo(12)
            make.width.equalTo(15)
        }
    }
}
