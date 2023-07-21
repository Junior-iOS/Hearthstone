//
//  NetworkProviderProtocol.swift
//  Hearthstone
//
//  Created by NJ Development on 18/07/23.
//

import Foundation

protocol NetworkProviderProtocol: AnyObject {
    func execute<T: Codable>(_ endpoint: AllCardsEndpoint, expecting type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
}
