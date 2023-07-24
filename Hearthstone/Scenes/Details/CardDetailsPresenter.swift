//
//  DetailsPresenter.swift
//  Hearthstone
//
//  Created by NJ Development on 18/07/23.
//  Copyright (c) 2023 NJ Development. All rights reserved.
//

import UIKit

protocol DetailsPresentationLogic {
    func presentSelectedCard(_ card: Card?)
}

class CardDetailsPresenter: DetailsPresentationLogic {
    weak var viewController: DetailsDisplayLogic?

    func presentSelectedCard(_ card: Card?) {
        viewController?.displaySelectedCard(card)
    }
}
