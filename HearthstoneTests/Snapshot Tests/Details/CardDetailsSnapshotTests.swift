//
//  CardDetailsSnapshotTests.swift
//  HearthstoneTests
//
//  Created by NJ Development on 24/07/23.
//

@testable import Hearthstone
import Nimble
import Nimble_Snapshots
import Quick

final class CardDetailsSnapshotTests: QuickSpec {
    private var recording = false

    override func spec() {
        var sut: CardDetailsViewController!

        describe("Opening the application") {
            context("on success") {
                it("loads the screen") {
//                    self.recording = true

                    sut = CardDetailsViewController()
                    sut.viewDidLoad()

                    sut.view.translatesAutoresizingMaskIntoConstraints = false
                    sut.view.widthAnchor.constraint(equalToConstant: 500).isActive = true
                    sut.view.heightAnchor.constraint(equalToConstant: 1_000).isActive = true

                    if self.recording {
                        expect(sut).toEventually(recordSnapshot(), timeout: .seconds(3))
                    } else {
                        expect(sut).toEventually(haveValidSnapshot(), timeout: .seconds(3))
                    }
                }
            }
        }
    }
}
