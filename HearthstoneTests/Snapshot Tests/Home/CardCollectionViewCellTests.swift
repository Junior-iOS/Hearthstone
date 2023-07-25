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
