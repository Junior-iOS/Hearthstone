//
//  String+Extensions.swift
//  Hearthstone
//
//  Created by NJ Development on 24/07/23.
//

import UIKit

extension String {
    func removeHTML() -> String {
        self.replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "</b>", with: "")
            .replacingOccurrences(of: "[x]", with: "")
    }
}
