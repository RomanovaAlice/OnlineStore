//
//  DetailCell.swift
//  OnlineStore
//
//  Created by Алиса Романова on 16.12.2022.
//

import SnapKit

class DetailCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    let imageView = UIImageView(clipsToBounds: true, radius: 15)
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(named: "white")
    
        setShadows()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setShadows() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 7
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.cornerRadius = 15
    }
}

//MARK: - Setup constraints

extension DetailCell {
    private func setupConstraints() {
        
        //imageView
        
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().inset(20)
        }
        
    }
}
