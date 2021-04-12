//
//  UINavigationController+.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 12/04/21.
//

import UIKit

extension UINavigationController {
    func clearNavigation() {
        navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
}
