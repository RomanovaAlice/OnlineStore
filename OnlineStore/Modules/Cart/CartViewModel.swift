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
    @Published var state: ViewModelState = .none

    @Published var searchData: Cart = Cart.placeholder

    init() {
        state = .loading
        
        service.getData(requestType: .cart).sink { event in
            switch event {
                
            case .finished:
                self.state = .success
            case .failure(_):
                self.state = .failure
            }
        } receiveValue: { data in
            self.searchData = data
        }.store(in: &cancelable)
    }
}
