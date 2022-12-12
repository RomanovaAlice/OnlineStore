//
//  NetworkService.swift
//  OnlineStore
//
//  Created by Алиса Романова on 08.12.2022.
//

import Combine
import Foundation

final class NetworkService {
    
    func getData(store: RequestType) -> AnyPublisher<Store, Error> {
        let url = URL(string: store.rawValue)
        
        return URLSession.shared.dataTaskPublisher(for: url!).map { $0.data }
            .decode(type: Store.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getData(phoneModel: RequestType) -> AnyPublisher<PhoneModel, Error> {
        let url = URL(string: phoneModel.rawValue)
        
        return URLSession.shared.dataTaskPublisher(for: url!).map { $0.data }
            .decode(type: PhoneModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getData(cart: RequestType) -> AnyPublisher<Cart, Error> {
        let url = URL(string: cart.rawValue)
        
        return URLSession.shared.dataTaskPublisher(for: url!).map { $0.data }
            .decode(type: Cart.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
