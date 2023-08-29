//
//  LocalizedStrings.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 11/04/21.
//

import Foundation

enum LocalizedStrings: String {
    case errorTitle
    case apiErrorMessage
    case okButtonTitle
    case openClosedTitle
    case openPullRequest

    func localized() -> String { rawValue.localized() }
}
