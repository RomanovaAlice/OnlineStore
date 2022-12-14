//
//  Cart.swift
//  OnlineStore
//
//  Created by Алиса Романова on 08.12.2022.
//

import Foundation

struct Cart: Decodable, Hashable {
    let basket: [Product]
    let delivery: String
    let id: String
    let total: Int
    
    static func == (lhs: Cart, rhs: Cart) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Product: Decodable, Hashable {
    let id: Int
    let images: String
    let price: Int
    let title: String
}
