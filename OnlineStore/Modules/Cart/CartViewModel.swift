//
//  CartViewModel.swift
//  OnlineStore
//
//  Created by Алиса Романова on 18.12.2022.
//

import Foundation
import Combine

final class CartViewModel {
    
    private let service = NetworkService()
    private var cancelable: Set<AnyCancellable> = []

    
    @Published var basket: [Product] = []
    @Published var delivery = ""
    @Published var images: [String] = []
    @Published var price = 0
    @Published var title = ""
}
