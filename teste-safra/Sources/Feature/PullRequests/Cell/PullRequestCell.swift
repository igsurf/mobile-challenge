//
//  PullRequestCell.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 12/04/21.
//

import UIKit

class PullRequestCell: UITableViewCell {

    // MARK: - Storyboard Outlets

    @IBOutlet var userFullNameLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!

    // MARK: - Private Properties

    private var viewModel: PullRequestCellViewModel?

    // MARK: - Life Cycle

    override func prepareForReuse() {
        super.prepareForReuse()
        userFullNameLabel.text = nil
        userNameLabel.text = nil
        descLabel.text = nil
        titleLabel.text = nil
        userImageView.image = nil
    }

    // MARK: - Public Methods

    func setup(viewModel: PullRequestCellViewModel) {
        self.viewModel = viewModel
        setupLabels()
    }

    // MARK: - Private Methods

    private func setupLabels() {
        userNameLabel.text = viewModel?.userName
        titleLabel.text = viewModel?.title
        descLabel.text = viewModel?.body
        userImageView.toCircle()
        viewModel?.getImage { image in
            DispatchQueue.main.async {
                self.userImageView.image = image
            }
        }
        viewModel?.getUserFullName { name in
            DispatchQueue.main.async {
                self.userFullNameLabel.text = name
            }
        }
     }
}
