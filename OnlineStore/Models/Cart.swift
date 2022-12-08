//
//  Cart.swift
//  OnlineStore
//
//  Created by Алиса Романова on 08.12.2022.
//

import Foundation

struct Cart: Decodable {
    let basket: [Product]
    let delivery: String
    let id: String
    let total: Int
}

struct Product: Decodable {
    let id: Int
    let images: String
    let price: Int
    let title: String
}
