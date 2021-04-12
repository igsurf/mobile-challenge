//
//  LocalizedStrings.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 11/04/21.
//

import Foundation

enum LocalizedStrings: String {
    case errorTitle = "errorTitle"
    case apiErrorMessage = "apiErrorMessage"
    case okButtonTitle = "okButtonTitle"

    func localized() -> String { rawValue.localized() }
}
