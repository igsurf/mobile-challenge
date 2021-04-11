//
//  CodeLanguageCellViewModel.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 10/04/21.
//

import UIKit

class CodeLanguageCellViewModel {

    // MARK: - Public Properties

    var language: CodeLanguage

    // MARK: - Life Cycle

    init(language: CodeLanguage) {
        self.language = language
    }

    // MARK: - Public Methods

    var buttonColor: UIColor {
        switch language {
        case .java:
            return #colorLiteral(red: 0.04705882353, green: 0.3764705882, blue: 0.5137254902, alpha: 1)
        case .swift:
            return #colorLiteral(red: 0.9333333333, green: 0.4470588235, blue: 0.1960784314, alpha: 1)
        case .kotlin:
            return #colorLiteral(red: 0.4, green: 0.6862745098, blue: 0.1568627451, alpha: 1)
        @unknown default:
            return UIColor()
        }
    }
}
