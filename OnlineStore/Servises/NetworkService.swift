//
//  NetworkService.swift
//  OnlineStore
//
//  Created by Алиса Романова on 08.12.2022.
//

import Combine
import Foundation

final class NetworkService {
    
    func getData<T>(requestType: RequestType) -> AnyPublisher<T, Error> where T: Decodable {
        let url = URL(string: requestType.rawValue)
        
        return URLSession.shared.dataTaskPublisher(for: url!).map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
