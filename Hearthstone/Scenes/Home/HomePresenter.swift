//
//  HomePresenter.swift
//  Hearthstone
//
//  Created by NJ Development on 18/07/23.
//  Copyright (c) 2023 NJ Development. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    func presentCard()
    func presentError(_ error: NetworkError)
    func presentAlert()
    func reloadData()
    func hideSpinner()
}

class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?

    func presentCard() {
        viewController?.displayCard()
    }
    
    func presentError(_ error: NetworkError) {
        viewController?.displayError(error)
    }
    
    func presentAlert() {
        viewController?.displayAlert()
    }
    
    func reloadData() {
        viewController?.reloadData()
    }
    
    func hideSpinner() {
        viewController?.hideSpinner()
    }
}
