//
//  MockNetworkProvider.swift
//  HearthstoneTests
//
//  Created by NJ Development on 24/07/23.
//

@testable import Hearthstone
import XCTest

class MockNetworkProvider: NetworkProviderProtocol {
    var isSuccess = true

    func execute<T>(_ endpoint: AllCardsEndpoint, expecting type: T.Type, completion: @escaping (Result<T, Hearthstone.NetworkError>) -> Void) where T: Codable {
        let card = Card(img: "https://d15f34w2p8l1cc.cloudfront.net/hearthstone/01f440d011b2c6c84ad6e902fc135977d638e60cac8c6f2993a62c69ab2bbe14.png",
                        name: "Genn Greymane",
                        flavor: "Ever since Sylvanas killed his son, he\'s dreamed of getting… even.",
                        text: "[x]<b>Start of Game:</b>\nIf your deck has only even-\nCost cards, your starting\nHero Power costs (1).",
                        cardSet: "Hall of Fame",
                        type: "Minion",
                        faction: nil,
                        rarity: "Legendary",
                        attack: 6,
                        cost: 6,
                        health: 5)
        let mock = Home.Response(hallOfFame: [card])

        if isSuccess {
            completion(.success(mock as! T))
        } else {
            completion(.failure(.apiError))
        }
    }
}
