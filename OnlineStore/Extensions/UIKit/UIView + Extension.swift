//
//  UIView + Extension.swift
//  OnlineStore
//
//  Created by Алиса Романова on 10.12.2022.
//

import SnapKit

extension UIView {
    
    convenience init(backgroundColor: UIColor? = .clear,
                     radius: CGFloat = 0) {
        self.init()
        
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = radius
    }
    
    convenience init(imageView: UIImageView, label: UILabel) {
        self.init()
        
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .gray
        
        imageView.tintColor = .gray
        
        self.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }
        
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(28)
            make.centerX.top.equalToSuperview()
        }
    }
}
