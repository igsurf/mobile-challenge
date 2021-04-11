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
        userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
        userImageView.clipsToBounds = true
        userFullNameLabel.text = .empty
        rateLabel.text = viewModel?.starCountsText
        getImage()
        getFullName()
    }

    private func getFullName() {
        viewModel?.getUserDetails(
            success: { user in
                DispatchQueue.main.async {
                    self.userFullNameLabel.text = user.name
                }
            },
            failure: { _ in
            })
    }

    private func getImage() {
        viewModel?.getImage(success: { image in
            DispatchQueue.main.async {
                self.userImageView?.image = image
            }
        }, failure: { error in
        })
    }
}
