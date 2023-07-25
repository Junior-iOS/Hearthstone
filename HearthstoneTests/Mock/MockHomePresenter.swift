//
//  MockHomePresenter.swift
//  HearthstoneTests
//
//  Created by NJ Development on 24/07/23.
//

@testable import Hearthstone
import XCTest

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
