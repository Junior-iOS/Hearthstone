//
//  CardCollectionViewCellTests.swift
//  HearthstoneTests
//
//  Created by NJ Development on 24/07/23.
//

@testable import Hearthstone
import Nimble
import Nimble_Snapshots
import Quick

final class CardCollectionViewCellTests: QuickSpec {
    private var recording = false

    override func spec() {
        var sut: CardCollectionViewCell!
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

        describe("Opening the application") {
            context("on success") {
                it("loads the screen") {
//                    self.recording = true

                    sut = CardCollectionViewCell()
                    sut.configure(with: card)

                    sut.translatesAutoresizingMaskIntoConstraints = false
                    sut.widthAnchor.constraint(equalToConstant: 700).isActive = true
                    sut.heightAnchor.constraint(equalToConstant: 1_000).isActive = true

                    if self.recording {
                        expect(sut).toEventually(recordSnapshot(), timeout: .seconds(3))
                    } else {
                        expect(sut).toEventually(haveValidSnapshot(), timeout: .seconds(10))
                    }
                }
            }
        }
    }
}
