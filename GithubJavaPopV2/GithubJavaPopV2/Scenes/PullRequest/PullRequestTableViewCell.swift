//
//  PullRequestTableViewCell.swift
//  GithubJavaPopV2
//
//  Created by Suh on 14/06/22.
//

import UIKit

class PullRequestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!

    var placeholder = UIImage(named: "placeholder.png")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func prepare(model: PullRequest) {
        titleLabel.text = model.title
        bodyLabel.text = model.body
        loginLabel.text = model.userLogin
        createdLabel.text = model.createdAt
        let url = URL(string: model.userAvatar)
        self.avatarImage.kf.setImage(with: url, placeholder: placeholder)
        avatarImage.layer.cornerRadius = avatarImage.frame.size.height/2
    }
    
}
 
