//
//  HomeRouter.swift
//  Hearthstone
//
//  Created by NJ Development on 18/07/23.
//  Copyright (c) 2023 NJ Development. All rights reserved.
//

import UIKit

@objc protocol HomeRoutingLogic {
    func routeToCardDetails()
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?

    // MARK: Routing
    func routeToCardDetails() {
        let vc = DetailsViewController()
        guard let destinationDataStore = vc.router?.dataStore else { return }
        var destinationDS = destinationDataStore
        passSpotlightDataToDetail(source: dataStore!, destination: &destinationDS)
        viewController?.present(vc, animated: true)
    }

    // MARK: Navigation
    func passSpotlightDataToDetail(source: HomeDataStore, destination: inout DetailsDataStore) {
        destination.selectedCard = source.selectedCard
    }
}
