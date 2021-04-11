//
//  BaseViewController.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 10/04/21.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Private Properties

    private var loadingView = LoadingView()

    // MARK: - Public Properties

    func showLoading() {
        view.addSubview(loadingView)
        loadingView.showLoading()
    }

    func hideLoading() {
        loadingView.hideLoading()
    }
}
