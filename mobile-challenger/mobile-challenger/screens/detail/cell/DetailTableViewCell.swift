//
//  DetailTableViewCell.swift
//  mobile-challenger
//
//  Created by Leonardo Sugano on 19/02/21.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var titlePullRequestLabel: UILabel?
    @IBOutlet weak var descriptionPullRequestLabel: UILabel?
    @IBOutlet weak var userImageView: RoundedImageView?
    @IBOutlet weak var userNameLabel: UILabel?
    @IBOutlet weak var nameLabel: UILabel?
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    //MARK: - Setups
    func setupColors() {
        self.titlePullRequestLabel?.textColor = .blueColor()
        self.descriptionPullRequestLabel?.textColor = .black
        self.userNameLabel?.textColor = .blueColor()
        self.nameLabel?.textColor = .lightGrayColor()
    }

}
