//
//  BestSellerCell.swift
//  OnlineStore
//
//  Created by Алиса Романова on 08.12.2022.
//

import SnapKit

class BestSellerCell: UICollectionViewCell {
    
    //MARK: - Properties

    
    //labels
    let priseLabel = UILabel(font: .systemFont(ofSize: 15, weight: .bold))
    let modelNameLabel = UILabel(font: .systemFont(ofSize: 10, weight: .light))
    let discontLabel = UILabel(font: .systemFont(ofSize: 8, weight: .thin), textColor: .systemGray)
    
    //imagesViews
    let imageView = UIImageView()
    let heartImageView = UIImageView(image: UIImage(systemName: "suit.heart"), tintColor: UIColor(named: "orange"))
    
    //views
    let heartView = UIView(backgroundColor: .white, radius: 12.5)
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        
        //
        
        self.addSubview(heartView)
        
        heartView.snp.makeConstraints { make in
            make.right.top.equalToSuperview().inset(10)
            make.height.width.equalTo(25)
        }
        
        //heartImageView
        
        heartView.addSubview(heartImageView)
        
        heartImageView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.height.width.equalTo(15)
        }
    }
}

