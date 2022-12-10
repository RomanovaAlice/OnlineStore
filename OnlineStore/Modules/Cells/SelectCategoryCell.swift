//
//  SelectCategoryCell.swift
//  OnlineStore
//
//  Created by Алиса Романова on 08.12.2022.
//

import SnapKit

class SelectCategoryCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    let circleView = UIView(backgroundColor: UIColor(named: "white")!, radius: 35)
    let imageView = UIImageView(tintColor: .systemGray3)
    let titleLabel = UILabel(font: .systemFont(ofSize: 13, weight: .medium))
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setShadows()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - isSelected
    
    override var isSelected: Bool {
        didSet {
            updateSelectedState()
        }
    }
    
    //MARK: - prepareForReuse
    
    override func prepareForReuse() {
        circleView.backgroundColor = nil
        imageView.tintColor = nil
        titleLabel.textColor = nil
    }
    
    //MARK: - Methods
    
    private func setShadows() {
        circleView.layer.shadowColor = UIColor.systemGray2.cgColor
        circleView.layer.shadowRadius = 4
        circleView.layer.shadowOpacity = 0.1
        circleView.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
    }
    
    private func updateSelectedState() {
        circleView.backgroundColor = isSelected ? UIColor(named: "orange") : UIColor(named: "white")
        imageView.tintColor = isSelected ? .white : .systemGray3
        titleLabel.textColor = isSelected ? UIColor(named: "orange") : .black
    }
}

//MARK: - Setup constraints

extension SelectCategoryCell {
    private func setupConstraints() {
        
        //circleView
        
        self.addSubview(circleView)
        
        circleView.snp.makeConstraints { make in
            make.height.width.equalTo(71)
            make.top.equalToSuperview().inset(5)
            make.centerX.equalToSuperview()
        }
        
        //imageView
        
        circleView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(35)
        }
    
        imageView.contentMode = .scaleAspectFit
        
        //titleLabel
        
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(circleView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
    }
}
