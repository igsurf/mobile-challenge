//
//  HomeTableViewCell.swift
//  mobile-challenger
//
//  Created by Leonardo Sugano on 19/02/21.
//

import UIKit
import SDWebImage

class HomeTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var titleRepository: UILabel?
    @IBOutlet weak var descriptionRepositoryLabel: UILabel?
    @IBOutlet weak var forkImageView: UIImageView?
    @IBOutlet weak var forkLabel: UILabel?
    @IBOutlet weak var starsLabel: UILabel?
    @IBOutlet weak var starImageView: UIImageView?
    @IBOutlet weak var perfilImagemView: RoundedImageView?
    @IBOutlet weak var userNameLabel: UILabel?
    @IBOutlet weak var nameLabel: UILabel?
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupColors() {
        self.forkImageView?.tintColor = .yellowColor()
        self.forkLabel?.textColor = .yellowColor()
        self.starsLabel?.textColor = .yellowColor()
        self.starImageView?.tintColor = .yellowColor()
        self.titleRepository?.textColor = .blueColor()
        self.userNameLabel?.textColor = .blueColor()
        self.nameLabel?.textColor = .lightGrayColor()
        self.descriptionRepositoryLabel?.textColor = .black
    }
    
    func setupCellWithRepositoriesDatas(response: RepositoriesModel) {
        self.forkLabel?.text = "\(response.forksCount?.intValue ?? 0)"
        self.starsLabel?.text = "\(response.starsCount?.intValue ?? 0)"
        self.descriptionRepositoryLabel?.text = response.descriptionRepository
        self.titleRepository?.text = response.repositoryName
        self.userNameLabel?.text = response.ownerUsername
        self.perfilImagemView?.sd_setImage(with: URL(string: response.ownerImage ?? ""), placeholderImage: UIImage(named: "img-perfil-placeholder"))
    }
    
    func setupCellWithModel() { //change name
        setupColors()
    }

}
