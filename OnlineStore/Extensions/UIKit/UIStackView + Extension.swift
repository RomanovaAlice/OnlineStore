//
//  UIStackView + Extension.swift
//  OnlineStore
//
//  Created by Алиса Романова on 12.12.2022.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], spacing: CGFloat, axis: NSLayoutConstraint.Axis = .vertical) {
        self.init(arrangedSubviews: arrangedSubviews)
        
        self.axis = axis
        self.spacing = spacing
    }
}
