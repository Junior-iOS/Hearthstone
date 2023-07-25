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
