//
//  UILabel + Extension.swift
//  OnlineStore
//
//  Created by Алиса Романова on 09.12.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String = "",
                     font: UIFont = .systemFont(ofSize: 15),
                     textColor: UIColor? = .black,
                     tintColor: UIColor? = .black,
                     numberOfLines: Int = 0,
                     textAlignment: NSTextAlignment = .left,
                     alpha: CGFloat = 1) {
        self.init()
        
        self.text = text
        self.font = font
        self.textColor = textColor
        self.tintColor = tintColor
        self.textAlignment = textAlignment
        self.alpha = alpha
        self.numberOfLines = numberOfLines
    }
}
