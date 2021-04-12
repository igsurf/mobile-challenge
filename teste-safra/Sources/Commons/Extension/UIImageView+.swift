//
//  UIImage+.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 12/04/21.
//

import UIKit

extension UIImageView {
    func toCircle() {
        layer.cornerRadius = frame.size.width / 2
        clipsToBounds = true
    }
}
