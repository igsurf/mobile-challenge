//
//  PullRequestTableViewCell.swift
//  GithubJavaPopV3
//
//  Created by Suh on 06/07/22.
//

import UIKit
import Kingfisher

class PullRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!

    var placeholder = UIImage(named: "placeholder2.png")

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func prepare(model: PullRequest) {
        titleLabel.text = model.title
        bodyLabel.text = model.body
        loginLabel.text = model.userLogin
        createdAtLabel.text = model.createdAt
        let url = URL(string: model.userAvatar)
        self.avatarImageView.kf.setImage(with: url, placeholder: placeholder)
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height/2
    }
}
