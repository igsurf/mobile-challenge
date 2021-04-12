//
//  String+.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 11/04/21.
//

import Foundation

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
}
