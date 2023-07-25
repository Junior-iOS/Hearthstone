//
//  HearthstoneTests.swift
//  HearthstoneTests
//
//  Created by NJ Development on 18/07/23.
//

@testable import Hearthstone
import XCTest

final class HomeInteractorTests: XCTestCase {
    private var sut: HomeInteractor!
    private var mockPresenter: MockHomePresenter!
    private var mockProvider: MockNetworkProvider!

    private var postAction: (() -> Void)?

    private lazy var card = Card(img: "https://d15f34w2p8l1cc.cloudfront.net/hearthstone/5f540fb42f80b768a5a6c2bf8ef9ac6e702515b886508b1b7e3040120f741183.png",
                    name: "Captain's Parrot",
                    flavor: "Pirates and Parrots go together like Virmen and Carrots.",
                    text: "<b>Battlecry:</b> Draw a Pirate from your deck.",
                    cardSet: "Hall of Fame",
                    type: "Minion",
                    faction: "",
                    rarity: "",
                    attack: 1,
                    cost: 2,
                    health: 1)

    private lazy var cards = [card, card, card]

    override func setUp() {
        super.setUp()
        mockPresenter = MockHomePresenter()
        mockProvider = MockNetworkProvider()
        sut = HomeInteractor(service: mockProvider)
        sut.presenter = mockPresenter
    }

    override func tearDown() {
        sut = nil
        mockPresenter = nil
        mockProvider = nil
        super.tearDown()
    }

    func testNumberOfRows() {
        let mockCards = cards
        sut.cards = mockCards
        XCTAssertEqual(sut.numberOfRows(for: 0), 3)
    }

    func testNumberOfRowsEmpty() {
        sut.cards = nil
        XCTAssertEqual(sut.numberOfRows(for: 0), 0)
    }

    func testDidSelectRowAt() {
        let mockCard = card
        sut.cards = [mockCard]
        sut.didSelectRowAt(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertEqual(sut.selectedCard, mockCard)
        XCTAssertTrue(mockPresenter.presentCardCalled)
    }

    func testFetchCardsSuccess() {
        sut.fetchCards()
        XCTAssertNotNil(self.sut.cards)
        XCTAssertTrue(self.mockPresenter.hideSpinnerCalled)
    }

    func testFetchCardsFailure() {
        mockProvider.isSuccess = false
        sut.fetchCards()
        XCTAssertNil(self.sut.cards)
        XCTAssertTrue(self.mockPresenter.presentErrorCalled)
    }

    func testShowAlert() {
        sut.showAlert()
        XCTAssertTrue(mockPresenter.presentAlertCalled)
    }
}

// Mock classes for testing
class MockHomePresenter: HomePresentationLogic {
    var reloadDataCalled = false
    var presentCardCalled = false
    var hideSpinnerCalled = false
    var presentErrorCalled = false
    var presentAlertCalled = false

    func reloadData() {
        reloadDataCalled = true
    }

    func presentCard() {
        presentCardCalled = true
    }

    func hideSpinner() {
        hideSpinnerCalled = true
    }

    func presentError(_ error: NetworkError) {
        presentErrorCalled = true
    }

    func presentAlert() {
        presentAlertCalled = true
    }
}

class MockNetworkProvider: NetworkProviderProtocol {
    var isSuccess = true

    func execute<T>(_ endpoint: AllCardsEndpoint, expecting type: T.Type, completion: @escaping (Result<T, Hearthstone.NetworkError>) -> Void) where T: Decodable, T: Encodable {
        let card = Card(img: "https://d15f34w2p8l1cc.cloudfront.net/hearthstone/5f540fb42f80b768a5a6c2bf8ef9ac6e702515b886508b1b7e3040120f741183.png",
                        name: "Captain's Parrot",
                        flavor: "Pirates and Parrots go together like Virmen and Carrots.",
                        text: "<b>Battlecry:</b> Draw a Pirate from your deck.",
                        cardSet: "Hall of Fame",
                        type: "Minion",
                        faction: "",
                        rarity: "",
                        attack: 1,
                        cost: 2,
                        health: 1)
        let mock = Home.Response(hallOfFame: [card])
        
        if isSuccess {
            completion(.success(mock as! T))
        } else {
            completion(.failure(.apiError))
        }
    }
}
