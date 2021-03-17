import UIKit

/// Cell for TableView to show Loading placeholder
class LoadingCell: UITableViewCell {
    static let cellIdentifier = String(describing: LoadingCell.self)

    @IBOutlet weak private var activittyIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        activittyIndicator.startAnimating()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
