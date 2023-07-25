//
//  AllCardsEndpoint.swift
//  Hearthstone
//
//  Created by NJ Development on 18/07/23.
//

import Foundation

struct AllCardsEndpoint {
    let path: String
    let method: String

    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Bundle.main.scheme
        urlComponents.host = Bundle.main.host
        urlComponents.path = path
        return urlComponents.url
    }

    var headerKeyField: String {
        Bundle.main.headerKeyField
    }

    var headerValue: String {
        Bundle.main.apiKey
    }

    var headerHostField: String {
        Bundle.main.headerHostField
    }

    var headerHostValue: String {
        Bundle.main.host
    }

    static func fetchCards() -> Self {
        Self(path: Bundle.main.endpoint, method: "GET")
    }
}
