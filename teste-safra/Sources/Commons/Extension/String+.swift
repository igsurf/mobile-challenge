//
//  String+.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 11/04/21.
//

import UIKit

extension String {
    static let empty = String()

    func localized() -> String {
        let pathBundle: Bundle = .main
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: pathBundle,
                                 value: .empty,
                                 comment: .empty)
    }

    func changeColor(in textsToChange: [String], color: UIColor) -> NSMutableAttributedString {
        let attributtedString = NSMutableAttributedString(string: self)
        textsToChange.forEach { text in
            let range = NSString(string: self).range(of: text)
            attributtedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        return attributtedString
    }
}
