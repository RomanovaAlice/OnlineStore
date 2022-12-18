//
//  CartCell.swift
//  OnlineStore
//
//  Created by Алиса Романова on 14.12.2022.
//

import SnapKit
import Combine

class CartCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    let counter = CurrentValueSubject<Int, Never>(2)
    private var cancelable: Set<AnyCancellable> = []
    private var currentCount = 2
    
    //labels
    let modelNameLabel = UILabel(font: .systemFont(ofSize: 17, weight: .semibold), textColor: .white)
    let countLabel = UILabel(font: .systemFont(ofSize: 16, weight: .semibold), textColor: .white)
    let priseLabel = UILabel(font: .systemFont(ofSize: 17, weight: .semibold), textColor: UIColor(named: "orange"))
    
    //buttons
    private let minusButton = UIButton(titntColor: .white, image: UIImage(systemName: "minus"))
    private let plusButton = UIButton(titntColor: .white, image: UIImage(systemName: "plus"))
    private let trashButton = UIButton(titntColor: .gray, image: UIImage(systemName: "trash"), alpha: 0.6)
    
    //imaegViews
    let phoneImageView = UIImageView(clipsToBounds: true, radius: 10)
    
    //views
    private let backgroundGrayView = UIView(backgroundColor: .systemGray, radius: 13, alpha: 0.3)
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addTargetsToButtons()
        bindCountLabel()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func bindCountLabel() {
        counter.sink { newValue in
            self.countLabel.text = "\(newValue)"
        }.store(in: &cancelable)
    }
    
    private func addTargetsToButtons() {
        plusButton.addTarget(self, action: #selector(plus), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minus), for: .touchUpInside)
    }
    
    @objc private func plus() {
        currentCount += 1
        counter.send(currentCount)
    }
    
    @objc private func minus() {
        currentCount -= 1
        counter.send(currentCount)
    }
}

//MARK: - Setup constraints

extension CartCell {
    private func setupConstraints() {
        
        //phoneImageView
        
        self.addSubview(phoneImageView)
        
        phoneImageView.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview()
            make.width.equalTo(75)
        }
        
        //modelNameLabel
        
        self.addSubview(modelNameLabel)
        
        modelNameLabel.snp.makeConstraints { make in
            make.left.equalTo(phoneImageView.snp.right).offset(15)
            make.top.equalToSuperview()
            make.right.equalToSuperview().inset(96)
        }
        
        //priseLabel
        
        self.addSubview(priseLabel)
        
        priseLabel.snp.makeConstraints { make in
            make.top.equalTo(modelNameLabel.snp.bottom).offset(8)
            make.left.equalTo(modelNameLabel)
        }
        
        //backgroundGrayView
        
        self.addSubview(backgroundGrayView)
        
        backgroundGrayView.snp.makeConstraints { make in
            make.width.equalTo(26)
            make.height.equalTo(68)
            make.right.equalToSuperview().inset(34)
            make.centerY.equalToSuperview()
        }
        
        //minusButton
        
        self.addSubview(minusButton)
        
        minusButton.snp.makeConstraints { make in
            make.height.width.equalTo(10)
            make.centerY.equalTo(backgroundGrayView).offset(-20)
            make.centerX.equalTo(backgroundGrayView)
        }
        
        //countLabel
        
        self.addSubview(countLabel)
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backgroundGrayView)
            make.centerX.equalTo(backgroundGrayView)
        }
        
        //plusButton
        
        self.addSubview(plusButton)
        
        plusButton.snp.makeConstraints { make in
            make.height.width.equalTo(10)
            make.centerY.equalTo(backgroundGrayView).offset(20)
            make.centerX.equalTo(backgroundGrayView)
        }
        
        //trashButton
        
        self.addSubview(trashButton)
        
        trashButton.snp.makeConstraints { make in
            make.left.equalTo(backgroundGrayView.snp.right).offset(15)
            make.height.width.equalTo(15)
            make.centerY.equalToSuperview()
        }
    }
}
