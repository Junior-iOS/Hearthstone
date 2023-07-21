//
//  HomeInteractor.swift
//  Hearthstone
//
//  Created by NJ Development on 18/07/23.
//  Copyright (c) 2023 NJ Development. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic {
    func fetchCards()
    func numberOfRows(for section: Int) -> Int
    func cellForRow(at index: Int) -> Card?
    func didSelectRowAt(indexPath: IndexPath)
    
    var navTitle: String { get }
}

protocol HomeDataStore {
    var cards: [Card]? { get set }
    var selectedCard: Card? { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    
    var cards: [Card]? {
        didSet {
            DispatchQueue.main.async {
                self.presenter?.reloadData()
            }
        }
    }
    
    var selectedCard: Card?
    var navTitle: String = Bundle.main.title

    private let service: NetworkProviderProtocol
    
    init(service: NetworkProviderProtocol = NetworkProvider()) {
        self.service = service
    }
    
    func numberOfRows(for section: Int) -> Int {
        cards?.count ?? 0
    }
    
    func cellForRow(at index: Int) -> Card? {
        return cards?[index]
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        guard let card = cards?[indexPath.row] else { return }
        selectedCard = card
        self.presenter?.presentCard()
    }
    
    func fetchCards() {
        service.execute(.fetchCards(), expecting: Home.Response.self) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let cards):
                    self.cards = cards.hallOfFame
                    self.presenter?.hideSpinner()
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
}
