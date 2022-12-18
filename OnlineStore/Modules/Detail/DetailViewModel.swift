//
//  DetailViewModel.swift
//  OnlineStore
//
//  Created by Алиса Романова on 18.12.2022.
//

import Foundation
import Combine

final class DetailViewModel {
    
    private let service = NetworkService()
    private var cancelable: Set<AnyCancellable> = []

    @Published var gpu = ""
    @Published var camera = ""
    @Published var capacity: [String] = []
    @Published var images: [String] = []
    @Published var isFavorites = false
    @Published var price = 0
    @Published var sd = ""
    @Published var ssd = ""
    @Published var title = ""
    
}
