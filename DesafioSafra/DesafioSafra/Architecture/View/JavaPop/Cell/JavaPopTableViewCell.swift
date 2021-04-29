//
//  JavaPopTableViewCell.swift
//  DesafioSafra
//
//  Created by Renato Ferraz on 27/04/21.
//

import UIKit

class JavaPopTableViewCell: UITableViewCell {

    @IBOutlet weak var nameRep: UILabel!
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var fork: UILabel!
    @IBOutlet weak var star: UILabel!
    @IBOutlet weak var imgContact: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var nameUser: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
