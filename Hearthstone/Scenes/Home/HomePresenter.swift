//
//  HomePresenter.swift
//  Hearthstone
//
//  Created by NJ Development on 18/07/23.
//  Copyright (c) 2023 NJ Development. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    func presentCards()
    func reloadData()
}

class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?

    func presentCards() {
        viewController?.displayCards()
    }
    
    func reloadData() {
        viewController?.reloadData()
    }
}
