//
//  DetailHeaderTableViewCell.swift
//  mobile-challenger
//
//  Created by Leonardo Sugano on 19/02/21.
//

import UIKit

class DetailHeaderTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel?

    //MARK: - Lets
    let boldFontSize: CGFloat = 14
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Setups
    func setupCellWithPR(open: Int, close: Int) {
        let stringValue = "\(open) opened / \(close) closed"

        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: stringValue)
        attributedString.setColorForText(textForAttribute: "\(open) opened", withColor: UIColor.yellowColor())
        attributedString.setColorForText(textForAttribute: "/ \(close) closed", withColor: UIColor.black)
        
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: boldFontSize)
        self.titleLabel?.attributedText = attributedString
    }
    
    
}
