//
//  HomeViewController.swift
//  Hearthstone
//
//  Created by NJ Development on 18/07/23.
//  Copyright (c) 2023 NJ Development. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayCards()
    func reloadData()
    func hideSpinner()
}

class HomeViewController: UICollectionViewController {
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    // MARK: Clean Swift
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchCards()
        setupView()
    }
    
    init() {
        super.init(collectionViewLayout: HomeViewController.createLayout())
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setupView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.identifier)
        title = interactor?.navTitle // Alterar para Bundle
        
        view.backgroundColor = .systemBackground

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always

        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        addComponents()
    }

    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25),
                                                                heightDimension: .absolute(150)))
            item.contentInsets.trailing = 16
            item.contentInsets.bottom = 16
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(500)
                ),
                subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.leading = 16
            return section
        }
    }
    
    private func addComponents() {
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        interactor?.didSelectRowAt(indexPath: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        interactor?.numberOfRows(for: section) ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.identifier, for: indexPath)
        cell.backgroundColor = .systemRed
        return cell
    }
}

extension HomeViewController: HomeDisplayLogic {
    func displayCards() {
        router?.routeToCardDetails()
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func hideSpinner() {
        spinner.stopAnimating()
    }
}
