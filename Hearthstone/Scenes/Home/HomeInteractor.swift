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
    func cellForRow(for section: Int) -> AnyObject?
    func didSelectRowAt(indexPath: IndexPath)
}

protocol HomeDataStore {
    var cards: [Card]? { get set }
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

    private let service: NetworkProviderProtocol
    
    init(service: NetworkProviderProtocol = NetworkProvider()) {
        self.service = service
    }
    
    func numberOfRows(for section: Int) -> Int {
        cards?.count ?? 0
    }
    
    func cellForRow(for section: Int) -> AnyObject? {
        return nil
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func fetchCards() {
        service.execute(.fetchCards(), expecting: Home.Response.self) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let cards):
                    self.cards = cards.hallOfFame
//                    self.presenter?.presentCards()
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
}
