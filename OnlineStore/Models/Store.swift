//
//  Store.swift
//  OnlineStore
//
//  Created by Алиса Романова on 07.12.2022.
//

import Foundation

struct Store: Decodable, Hashable {

    let home_store: [HomeStore]
    let best_seller: [BestSeller]
    
    static func == (lhs: Store, rhs: Store) -> Bool {
        return lhs.home_store[0].id == rhs.home_store[0].id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(home_store[0].id)
    }
    
    static let placeholder = Store(home_store: [HomeStore(id: 0, is_new: false, title: "", subtitle: "", picture: "", is_buy: false)], best_seller: [BestSeller(id: 0, is_favorites: false, title: "", price_without_discount: 0, discount_price: 0, picture: "")])
}

struct HomeStore: Decodable, Hashable {
    let id: Int
    let is_new: Bool?
    let title: String
    let subtitle: String
    let picture: String
    let is_buy: Bool
}

struct BestSeller: Decodable, Hashable {
    let id: Int
    let is_favorites: Bool
    let title: String
    let price_without_discount: Int
    let discount_price: Int
    let picture: String
}
