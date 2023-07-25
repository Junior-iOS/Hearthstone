//
//  CardDetailsInteractorTests.swift
//  HearthstoneTests
//
//  Created by NJ Development on 24/07/23.
//

@testable import Hearthstone
import XCTest

final class CardDetailsInteractorTests: XCTestCase {
    private var interactor: CardDetailsInteractor!
    private var presenterMock: DetailsPresentationLogicMock!
    private var selectedCardMock: Card!

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

    override func setUp() {
        super.setUp()
        interactor = CardDetailsInteractor()
        presenterMock = DetailsPresentationLogicMock()
        selectedCardMock = card

        interactor.presenter = presenterMock
        interactor.selectedCard = selectedCardMock
    }

    override func tearDown() {
        interactor = nil
        presenterMock = nil
        selectedCardMock = nil
        super.tearDown()
    }

    func testShowSelectedCard() {
        interactor.showSelectedCard()

        XCTAssertTrue(presenterMock.presentSelectedCardCalled)
        XCTAssertEqual(presenterMock.presentSelectedCardParameter, selectedCardMock)
    }
}

class DetailsPresentationLogicMock: DetailsPresentationLogic {
    var presentSelectedCardCalled = false
    var presentSelectedCardParameter: Card?

    func presentSelectedCard(_ card: Card?) {
        presentSelectedCardCalled = true
        presentSelectedCardParameter = card
    }
}
