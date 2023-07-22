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
    func presentError()
    func reloadData()
    func hideSpinner()
}

class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?

    func presentCard() {
        viewController?.displayCard()
    }
    
    func presentError() {
        viewController?.displayError()
    }
    
    func reloadData() {
        viewController?.reloadData()
    }
    
    func hideSpinner() {
        viewController?.hideSpinner()
    }
}
