//
//  UIViewController+Extensions.swift
//  Hearthstone
//
//  Created by NJ Development on 23/07/23.
//

import UIKit

extension UIViewController {
    func showAlert(message: String, completion: (() -> Void)?) {
        let alert = UIAlertController(title: "Ops!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tentar novamente", style: .default, handler: { _ in
            completion?()
        }))
        present(alert, animated: true)
    }
}
