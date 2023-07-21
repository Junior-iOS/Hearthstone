//
//  UIView+Extensions.swift
//  Hearthstone
//
//  Created by NJ Development on 21/07/23.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}

