//
//  ErrorView.swift
//  Hearthstone
//
//  Created by NJ Development on 21/07/23.
//

import UIKit

protocol ErrorViewDelegate: AnyObject {
    func didTapTryAgain()
}

final class ErrorView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "error")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Try Again", for: .normal)
        button.backgroundColor = .systemCyan
        button.addTarget(self, action: #selector(errorButtonWasTapped), for: .touchUpInside)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, tryAgainButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 16
        return stack
    }()

    weak var delegate: ErrorViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func errorButtonWasTapped() {
        delegate?.didTapTryAgain()
    }

    private func setup() {
        backgroundColor = UIColor(red: 54 / 255, green: 169 / 255, blue: 148 / 255, alpha: 1)
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),

            tryAgainButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            tryAgainButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
