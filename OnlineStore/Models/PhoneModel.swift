//
//  PhoneModel.swift
//  OnlineStore
//
//  Created by Алиса Романова on 08.12.2022.
//

import Foundation

struct PhoneModel: Decodable {
    let CPU: String
    let camera: String
    let capacity: [String]
    let color: [String]
    let id: String
    let images: [String]
    let isFavorites: Bool
    let price: Int
    let rating: Float
    let sd: String
    let ssd: String
    let title: String
    
    static let placeholder = PhoneModel(CPU: "", camera: "", capacity: [""], color: [""], id: "", images: [""], isFavorites: false, price: 0, rating: 0, sd: "", ssd: "", title: "")
}
