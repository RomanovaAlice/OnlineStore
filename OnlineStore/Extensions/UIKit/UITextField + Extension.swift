//
//  UITextField + Extension.swift
//  OnlineStore
//
//  Created by Алиса Романова on 09.12.2022.
//

import UIKit

extension UITextField {
    convenience init(backgroundColor: UIColor? = .clear,
                     tintColor: UIColor? = .clear,
                     placeholder: String = "",
                     textColor: UIColor? = .black,
                     radius: CGFloat = 0) {
        self.init()
        
        self.placeholder = placeholder
        self.tintColor = tintColor
        self.textColor = textColor
        self.layer.cornerRadius = radius
        self.backgroundColor = backgroundColor
        
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: self.frame.height))
        self.leftViewMode = .always
        
    }
}
