//
//  UIView + Extension.swift
//  OnlineStore
//
//  Created by Алиса Романова on 10.12.2022.
//

import SnapKit

extension UIView {
    
    convenience init(backgroundColor: UIColor? = .clear,
                     radius: CGFloat = 0,
                     alpha: CGFloat = 1) {
        self.init()
        
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = radius
        self.alpha = alpha
    }
}
