//
//  String + Extension.swift
//  OnlineStore
//
//  Created by Алиса Романова on 09.12.2022.
//

import Foundation

extension String {
    
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: 1,
            range: NSRange(location: 0, length: attributeString.length))
        
        return attributeString
    }
}
