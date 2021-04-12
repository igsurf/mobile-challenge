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

    // MARK: - Life Cycle

    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.image = nil
        repositoryNameLabel.text = nil
        repositoryDescriptionLabel.text = nil
        forkCountLabel.text = nil
        rateLabel.text = nil
        userNameLabel.text = nil
        userFullNameLabel.text = nil
    }

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
        userImageView.toCircle()
        userFullNameLabel.text = .empty
        rateLabel.text = viewModel?.starCountsText
        getImage()
        getFullName()
    }

    private func getFullName() {
        viewModel?.getUserFullName { name in
            DispatchQueue.main.async {
                self.userFullNameLabel.text = name
            }
        }
    }

    private func getImage() {
        viewModel?.getImage { image in
            DispatchQueue.main.async {
                self.userImageView?.image = image
            }
        }
    }
}
