//
//  HomeTableViewCell.swift
//  mobile-challenger
//
//  Created by Leonardo Sugano on 19/02/21.
//

import UIKit

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
    
    func setupCellWithModel() { //change name
        setupColors()
    }

}
