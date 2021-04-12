//
//  BaseCoordinator.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 12/04/21.
//

import UIKit

@objc
protocol BaseCoordinator: AnyObject {
    @objc
    optional func start(navigationController: UINavigationController?)
}
