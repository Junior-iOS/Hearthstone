//
//  CardCollectionViewCell.swift
//  Hearthstone
//
//  Created by NJ Development on 21/07/23.
//

import SDWebImage
import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    private lazy var cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "card")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.addShadow(UIColor.systemRed.cgColor)
        return imageView
    }()

    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        cardImage.image = UIImage(named: "card")
    }

    private func setupCell() {
        contentView.addSubview(cardImage)

        NSLayoutConstraint.activate([
            cardImage.topAnchor.constraint(equalTo: topAnchor, constant: .kMargins),
            cardImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .kMargins),
            cardImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.kMargins),
            cardImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.kMargins)
        ])
    }

    func configure(with card: Card) {
        guard let img = card.img,
              let url = URL(string: img) else { return }

        DispatchQueue.main.async {
            self.cardImage.sd_setImage(with: url)
        }
    }
}

// MARK: - Constants
fileprivate extension CGFloat {
    static let kMargins: CGFloat = 10
}
