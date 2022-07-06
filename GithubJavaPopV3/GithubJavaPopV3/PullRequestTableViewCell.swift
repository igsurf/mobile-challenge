//
//  PullRequestTableViewCell.swift
//  GithubJavaPopV3
//
//  Created by Suh on 06/07/22.
//

import UIKit

class PullRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    
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
        avatarImageView.image = nil
    }
    
}

