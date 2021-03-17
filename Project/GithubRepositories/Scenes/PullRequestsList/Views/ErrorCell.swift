import UIKit

/// Cell for TableView to show error message
class ErrorCell: UITableViewCell {
    static let cellIdentifier = String(describing: ErrorCell.self)

    @IBOutlet weak var messageLabel: UILabel!

    /// Clusure called when the retry button is touched. the implementation is mandatory
    var onCallRetry: () -> Void = {
        fatalError("Retry action must be implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func retryButton() {
        onCallRetry()
    }
}
