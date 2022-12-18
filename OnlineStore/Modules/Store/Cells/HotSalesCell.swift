//
//  HotSalesCell.swift
//  OnlineStore
//
//  Created by Алиса Романова on 08.12.2022.
//

import SnapKit

class HotSalesCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    let imageView = UIImageView()
    let newButton = UIButton(backgroundColor: UIColor(named: "orange"), font: .systemFont(ofSize: 10), title: "New", textColor: .white, radius: 13.5)
    let buyNowButton = UIButton(backgroundColor: UIColor(named: "white"), font: .systemFont(ofSize: 11), title: "Buy now!", radius: 5)
    let modelNameLabel = UILabel(font: .systemFont(ofSize: 25, weight: .bold), textColor: .white)
    let subTitleLabel = UILabel(font: .systemFont(ofSize: 11, weight: .regular), textColor: .white)

    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSelfAppearance()
        setupCnstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupSelfAppearance() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}

//MARK: - Setup cnstraints

extension HotSalesCell {
    private func setupCnstraints() {
        
        //imageView
        
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        //newButton
        
        self.addSubview(newButton)
        
        newButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(15)
            make.width.height.equalTo(27)
        }
        
        //buyNowButton
        
        self.addSubview(buyNowButton)
        
        buyNowButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(19)
            make.height.equalTo(23)
            make.width.equalTo(98)
        }
        
        //modelNameLabel
        
        self.addSubview(modelNameLabel)
        
        modelNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(newButton.snp.bottom).offset(20)
        }
        
        //subTitleLabel
        
        self.addSubview(subTitleLabel)
        
        subTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalTo(modelNameLabel.snp.bottom).offset(5)
        }
    }
}
