//
//  Coordinator.swift
//  GithubJavaPopV3
//
//  Created by Suh on 29/07/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
