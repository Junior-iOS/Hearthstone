//
//  AllCardsEndpoint.swift
//  Hearthstone
//
//  Created by NJ Development on 18/07/23.
// https://omgvamp-hearthstone-v1.p.rapidapi.com/cards

import Foundation

struct AllCardsEndpoint {
    let path: String
    let method: String

    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "omgvamp-hearthstone-v1.p.rapidapi.com"
        urlComponents.path = path
        return urlComponents.url
    }
    
    var headerKeyField: String {
        "X-RapidAPI-Key"
    }

    var headerValue: String {
        "5c41435c63msh183d9e3129768a4p12e19ejsnd3dce1dcf0c9"
    }

    var headerHostField: String {
        "X-RapidAPI-Host"
    }

    var headerHostValue: String {
        "omgvamp-hearthstone-v1.p.rapidapi.com"
    }

    static func fetchCards() -> Self {
        Self(path: "/cards", method: "GET")
    }
}

