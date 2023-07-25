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

    private let card = Card(img: "https://d15f34w2p8l1cc.cloudfront.net/hearthstone/01f440d011b2c6c84ad6e902fc135977d638e60cac8c6f2993a62c69ab2bbe14.png",
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
