//
//  DetailsRouter.swift
//  Hearthstone
//
//  Created by NJ Development on 18/07/23.
//  Copyright (c) 2023 NJ Development. All rights reserved.
//

import UIKit

@objc protocol DetailsRoutingLogic {
    // func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol DetailsDataPassing {
    var dataStore: DetailsDataStore? { get }
}

class DetailsRouter: NSObject, DetailsRoutingLogic, DetailsDataPassing {
    weak var viewController: CardDetailsViewController?
    var dataStore: DetailsDataStore?
}
