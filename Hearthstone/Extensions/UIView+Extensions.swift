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
    
    func addShadow(_ color: CGColor?) {
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        layer.shadowRadius = 5.0
        layer.shadowColor = color
        layer.masksToBounds = false
    }
    
    func createLabel(ofSize fontSize: CGFloat,
                     weight: UIFont.Weight = .regular,
                     alignment: NSTextAlignment = .center,
                     cornerRadius: CGFloat = 0) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: fontSize, weight: weight)
        label.numberOfLines = 0
        label.text = "Yet to be discovered!"
        label.textColor = UIColor(red: 0.10, green: 0.12, blue: 0.21, alpha: 1.00)
        label.textAlignment = alignment
        label.layer.cornerRadius = cornerRadius
        label.clipsToBounds = true
        
        return label
    }
}

