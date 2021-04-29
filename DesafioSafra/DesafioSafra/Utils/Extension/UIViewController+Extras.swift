//
//  UIViewController+Extras.swift
//  DesafioSafra
//
//  Created by Renato Ferraz on 28/04/21.
//

import Foundation
import UIKit

extension UIViewController {
    open override func awakeFromNib() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = UIColor.white;

    }
}
