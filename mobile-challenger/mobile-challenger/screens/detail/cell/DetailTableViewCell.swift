//
//  DetailTableViewCell.swift
//  mobile-challenger
//
//  Created by Leonardo Sugano on 19/02/21.
//

import UIKit
import SDWebImage

class DetailTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var titlePullRequestLabel: UILabel?
    @IBOutlet weak var descriptionPullRequestLabel: UILabel?
    @IBOutlet weak var userImageView: RoundedImageView?
    @IBOutlet weak var userNameLabel: UILabel?
    @IBOutlet weak var dateLabel: UILabel?
    
    //MARK: - Lets
    let dateFormat = "dd/MM/yyyy HH:mm:ss"
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    //MARK: - Setups
    func setupColors() {
        self.titlePullRequestLabel?.textColor = .blueColor()
        self.descriptionPullRequestLabel?.textColor = .black
        self.userNameLabel?.textColor = .blueColor()
        self.dateLabel?.textColor = .lightGrayColor()
    }

    func setupCellWithPullRequest(request: PullRequestModel?) {
        self.titlePullRequestLabel?.text = request?.titlePR
        self.descriptionPullRequestLabel?.text = request?.descriptionPR
        self.descriptionPullRequestLabel?.sizeToFit()
        self.userNameLabel?.text = request?.ownerUsername
        self.dateLabel?.text = request?.createDate?.transformDateToFormat(format: dateFormat)
        self.userImageView?.sd_setImage(with: URL(string: request?.ownerImage ?? ""), placeholderImage: UIImage(named: "img-perfil-placeholder"))
    }
}
