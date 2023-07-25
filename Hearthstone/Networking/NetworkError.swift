//
//  NetworkError.swift
//  Hearthstone
//
//  Created by NJ Development on 18/07/23.
//

import Foundation

enum NetworkError: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError

    var localizedDescription: String {
        switch self {
        case .apiError:
            return "The API is unreachable, please contact the API provider"
        case .invalidEndpoint:
            return "invalid Endpoint"
        case .invalidResponse:
            return "invalid Response"
        case .noData:
            return "No Data"
        case .serializationError:
            return "Failed to Decode data"
        }
    }
}
