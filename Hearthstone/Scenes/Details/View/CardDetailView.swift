//
//  CardDetailView.swift
//  Hearthstone
//
//  Created by NJ Development on 22/07/23.
//

import UIKit
import SDWebImage

final class CardDetailView: UIView {
    
    private lazy var cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "card")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.addShadow(UIColor.systemYellow.cgColor)
        return imageView
    }()
    
    private lazy var detailBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.78, green: 0.67, blue: 0.53, alpha: 1.00)
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.addShadow(UIColor.systemYellow.cgColor)
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        createLabel(ofSize: 17, weight: .bold)
    }()
    
    private lazy var typeLabel: UILabel = {
        createLabel(ofSize: 17, weight: .bold)
    }()
    
    private lazy var nameTypeStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, typeLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 8
        return stack
    }()
    
    private lazy var costLabel: UILabel = {
        createLabel(ofSize: 14, weight: .semibold)
    }()
    
    private lazy var attackLabel: UILabel = {
        createLabel(ofSize: 14, weight: .semibold)
    }()
    
    private lazy var healthLabel: UILabel = {
        createLabel(ofSize: 14, weight: .semibold)
    }()
    
    private lazy var costAttackHealthStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [costLabel, attackLabel, healthLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()
    
    private lazy var textLabel: UILabel = {
        createLabel(ofSize: 16, weight: .regular)
    }()
    
    private lazy var flavorLabel: UILabel = {
        createLabel(ofSize: 16, weight: .regular)
    }()
    
    private lazy var textFlavorStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [textLabel, flavorLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 16
        return stack
    }()
    
    private lazy var setLabel: UILabel = {
        createLabel(ofSize: 14, weight: .semibold)
    }()
    
    private lazy var factionLabel: UILabel = {
        createLabel(ofSize: 14, weight: .semibold)
    }()
    
    private lazy var rarityLabel: UILabel = {
        createLabel(ofSize: 14, weight: .semibold)
    }()
    
    private lazy var setFactionRarityStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [setLabel, factionLabel, rarityLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameTypeStack,
                                                   costAttackHealthStack,
                                                   textFlavorStack,
                                                   setFactionRarityStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var emptyText = "Yet to be discovered"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setup() {
        addSubviews(cardImage, detailBackgroundView)
        detailBackgroundView.addSubviews(vStack)
        
        NSLayoutConstraint.activate([
            cardImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            cardImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3),
            
            detailBackgroundView.topAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: 20),
            detailBackgroundView.leadingAnchor.constraint(equalTo: cardImage.leadingAnchor),
            detailBackgroundView.trailingAnchor.constraint(equalTo: cardImage.trailingAnchor),
            detailBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            vStack.topAnchor.constraint(equalTo: detailBackgroundView.topAnchor, constant: 20),
            vStack.leadingAnchor.constraint(equalTo: detailBackgroundView.leadingAnchor, constant: 20),
            vStack.trailingAnchor.constraint(equalTo: detailBackgroundView.trailingAnchor, constant: -20),
            vStack.bottomAnchor.constraint(equalTo: detailBackgroundView.bottomAnchor, constant: -30),
            
            nameTypeStack.topAnchor.constraint(equalTo: vStack.topAnchor),
            nameTypeStack.leadingAnchor.constraint(equalTo: vStack.leadingAnchor),
            nameTypeStack.trailingAnchor.constraint(equalTo: vStack.trailingAnchor),
            nameTypeStack.heightAnchor.constraint(equalToConstant: 50),
            
            costAttackHealthStack.topAnchor.constraint(equalTo: nameTypeStack.bottomAnchor),
            costAttackHealthStack.leadingAnchor.constraint(equalTo: nameTypeStack.leadingAnchor),
            costAttackHealthStack.trailingAnchor.constraint(equalTo: nameTypeStack.trailingAnchor),
            
            textFlavorStack.topAnchor.constraint(equalTo: costAttackHealthStack.bottomAnchor),
            textFlavorStack.leadingAnchor.constraint(equalTo: costAttackHealthStack.leadingAnchor),
            textFlavorStack.trailingAnchor.constraint(equalTo: costAttackHealthStack.trailingAnchor),
            
            setFactionRarityStack.topAnchor.constraint(equalTo: textFlavorStack.bottomAnchor),
            setFactionRarityStack.leadingAnchor.constraint(equalTo: textFlavorStack.leadingAnchor),
            setFactionRarityStack.trailingAnchor.constraint(equalTo: textFlavorStack.trailingAnchor),
            setFactionRarityStack.bottomAnchor.constraint(equalTo: vStack.bottomAnchor),
            setFactionRarityStack.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func configureView(with card: Card) {
        DispatchQueue.main.async {
            self.nameLabel.text = card.name
            self.typeLabel.text = card.type
            self.costLabel.text = "COST\n\(card.cost ?? 0)"
            self.attackLabel.text = "ATTACK\n\(card.attack ?? 0)"
            self.healthLabel.text = "HEALTH\n\(card.health ?? 0)"
            self.textLabel.text = card.text?.removeHTML()
            self.flavorLabel.text = card.flavor?.removeHTML()
            self.setLabel.text = "SET\n\(card.cardSet ?? self.emptyText)"
            self.factionLabel.text = "FACTION\n\(card.faction ?? self.emptyText)"
            self.rarityLabel.text = "RARITY\n\(card.rarity ?? self.emptyText)"
            
            guard let img = card.img,
                  let url = URL(string: img) else { return }
            self.cardImage.sd_setImage(with: url)
        }
    }
}
