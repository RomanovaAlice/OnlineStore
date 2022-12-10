//
//  UIView + Extension.swift
//  OnlineStore
//
//  Created by Алиса Романова on 10.12.2022.
//

import UIKit

extension UIView {
    convenience init(backgroundColor: UIColor? = .clear,
                     radius: CGFloat = 0) {
        self.init()
        
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = radius
    }
}
