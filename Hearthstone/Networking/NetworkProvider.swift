//
//  NetworkProvider.swift
//  Hearthstone
//
//  Created by NJ Development on 18/07/23.
//

import Foundation

final class NetworkProvider: NetworkProviderProtocol {
    func execute<T: Codable>(_ endpoint: AllCardsEndpoint, expecting type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
//        let headers = [
//            endpoint.headerKeyField: endpoint.headerValue,
//            endpoint.headerHostField: endpoint.headerHostValue
//        ]

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
//        request.allHTTPHeaderFields = headers
        request.setValue(endpoint.headerValue, forHTTPHeaderField: endpoint.headerKeyField)
        request.setValue(endpoint.headerHostValue, forHTTPHeaderField: endpoint.headerHostField)

        loadUrlAndDecode(request, completion: completion)
    }

    private func loadUrlAndDecode<T: Decodable>(_ url: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self else { return }

            guard error == nil, let data else {
                executeCompletionHandler(with: .failure(.apiError), completion: completion)
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                executeCompletionHandler(with: .success(decodedResponse), completion: completion)
            } catch {
                executeCompletionHandler(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }

    private func executeCompletionHandler<T: Decodable>(with result: Result<T, NetworkError>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
