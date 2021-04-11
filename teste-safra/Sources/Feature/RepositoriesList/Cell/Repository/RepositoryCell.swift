//
//  RepositoryCell.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 11/04/21.
//

import UIKit

class RepositoryCell: UITableViewCell {

    // MARK: - Storyboard Outlets

    @IBOutlet var repositoryNameLabel: UILabel!
    @IBOutlet var repositoryDescriptionLabel: UILabel!
    @IBOutlet var forkCountLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userFullNameLabel: UILabel!

    // MARK: - Private Properties

    private var viewModel: RepositoryCellViewModel?

    // MARK: - Public Methods

    func setup(viewModel: RepositoryCellViewModel) {
        self.viewModel = viewModel
        setupLabels()
    }

    // MARK: - Private Methods

    private func setupLabels() {
        repositoryNameLabel.text =  viewModel?.repositoryName
        repositoryDescriptionLabel.text = viewModel?.repositoryDesc
        forkCountLabel.text = viewModel?.forksCountText
        userNameLabel.text = viewModel?.username
    }
}
