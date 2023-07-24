//
//  DetailsViewController.swift
//  Hearthstone
//
//  Created by NJ Development on 18/07/23.
//  Copyright (c) 2023 NJ Development. All rights reserved.
//

import UIKit

protocol DetailsDisplayLogic: AnyObject {
    func displaySelectedCard(_ card: Card?)
}

class CardDetailsViewController: UIViewController {
    private let cardDetailsView = CardDetailView()
    
    // MARK: Clean Swift
    var interactor: DetailsBusinessLogic?
    var router: (NSObjectProtocol & DetailsRoutingLogic & DetailsDataPassing)?

    // MARK: Setup
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func loadView() {
        super.loadView()
        self.view = cardDetailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor?.showSelectedCard()
    }

    private func setup() {
        let viewController = self
        let interactor = CardDetailsInteractor()
        let presenter = CardDetailsPresenter()
        let router = DetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.12, alpha: 1.00)
    }
}

extension CardDetailsViewController: DetailsDisplayLogic {
    func displaySelectedCard(_ card: Card?) {
        guard let card = card else { return }
        cardDetailsView.configureView(with: card)
    }
}
