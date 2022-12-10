//
//  UIButton + Extension.swift
//  OnlineStore
//
//  Created by Алиса Романова on 09.12.2022.
//

import UIKit

extension UIButton {
    convenience init(backgroundColor: UIColor? = nil,
                     font: UIFont = .systemFont(ofSize: 15),
                     title: String = "",
                     textColor: UIColor? = .black,
                     titntColor: UIColor? = .black,
                     image: UIImage? = nil,
                     radius: CGFloat = 0) {
        self.init()
        
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = radius
        self.setTitleColor(textColor, for: .normal)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.imageView?.tintColor = titntColor
        
        if image != nil {
            self.setImage(image, for: .normal)
        }
    }
}
