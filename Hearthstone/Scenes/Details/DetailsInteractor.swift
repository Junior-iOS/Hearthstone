//
//  DetailsInteractor.swift
//  Hearthstone
//
//  Created by NJ Development on 18/07/23.
//  Copyright (c) 2023 NJ Development. All rights reserved.
//

import UIKit

protocol DetailsBusinessLogic {
    func showSelectedCard()
}

protocol DetailsDataStore {
    var cards: [Card]? { get set }
}

class DetailsInteractor: DetailsBusinessLogic, DetailsDataStore {
    
    var presenter: DetailsPresentationLogic?
    var worker: DetailsWorker?
    var cards: [Card]?

    func showSelectedCard() {
        cards?.forEach({ print($0) })
    }
}