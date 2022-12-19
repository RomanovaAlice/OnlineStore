//
//  UIImageView + Extension.swift
//  OnlineStore
//
//  Created by Алиса Романова on 09.12.2022.
//

import UIKit

extension UIImageView {
    convenience init(image: UIImage? = nil,
                     backgroundColor: UIColor? = .clear,
                     tintColor: UIColor? = .clear,
                     clipsToBounds: Bool = false,
                     radius: CGFloat = 0,
                     alpha: CGFloat = 1) {
        self.init()
        
        self.image = image
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = radius
        self.clipsToBounds = clipsToBounds
        self.alpha = alpha
    }
}
   
extension UIImageView {
    func load(url: String) {
        let url = URL(string: url)
        DispatchQueue.global().async { [weak self] in
            guard url != nil else { return }
            if let data = try? Data(contentsOf: url!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
