//
//  HomeViewController.swift
//  Hearthstone
//
//  Created by NJ Development on 18/07/23.
//  Copyright (c) 2023 NJ Development. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayCard()
    func displayError(_ error: NetworkError)
    func displayAlert()
    func reloadData()
    func hideSpinner()
}

class HomeViewController: UICollectionViewController {
    // MARK: - Properties
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        return spinner
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Bear with me...\nThis might take a few seconds!\n\n🐻"
        return label
    }()

    private lazy var internetOutImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "internet_outage")
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        setupView()

        if NetworkMonitor.shared.isConnected {
            interactor?.fetchCards()
        } else {
            interactor?.showAlert()
        }
    }

    // MARK: - Init
    init() {
        super.init(collectionViewLayout: Self.createLayout())
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Methods
    private func setupView() {
        view.backgroundColor = .systemBackground
        internetOutImage.isHidden = true

        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        collectionView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.12, alpha: 1.00)

        navigationItem.title = "Hall of Fame"

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
        UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.33),
                                                                heightDimension: .absolute(170)))
            item.contentInsets.trailing = 16
            item.contentInsets.bottom = 16

            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                             heightDimension: .estimated(500)
                                                                            ), subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.leading = 16
            return section
        }
    }

    private func addComponents() {
        view.addSubviews(spinner, textLabel, internetOutImage)

        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            textLabel.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: 16),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            internetOutImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            internetOutImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            internetOutImage.heightAnchor.constraint(equalToConstant: 300),
            internetOutImage.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}

// MARK: - CollectionView Delegate and DataSource
extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        interactor?.didSelectRowAt(indexPath: indexPath)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        interactor?.numberOfRows(for: section) ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CardCollectionViewCell.identifier,
            for: indexPath) as? CardCollectionViewCell else {
            return UICollectionViewCell()
        }

        guard let card = interactor?.cellForRow(at: indexPath.row) else { return UICollectionViewCell() }
        cell.configure(with: card)

        return cell
    }
}

// MARK: - HomeDisplayLogic
extension HomeViewController: HomeDisplayLogic {
    func displayCard() {
        router?.routeToCardDetails()
    }

    func displayError(_ error: NetworkError) {
        showAlert(message: error.localizedDescription) {
            self.interactor?.fetchCards()
        }
    }

    func displayAlert() {
        internetOutImage.isHidden = false
    }

    func reloadData() {
        collectionView.reloadData()
    }

    func hideSpinner() {
        textLabel.isHidden = true
        spinner.stopAnimating()
    }
}
