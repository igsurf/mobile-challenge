//
//  roundedImageView.swift
//  mobile-challenger
//
//  Created by Leonardo Sugano on 19/02/21.
//

import UIKit


class RoundedImageView: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.set(cornerRadius: cornerRadius)
        }
    }
    
    private func set(cornerRadius value: CGFloat) {
        self.layer.cornerRadius = value
        self.clipsToBounds = true
    }
}
