import UIKit

/// Cell for UITableView to show a recipe.
class PullRequestCell: UITableViewCell {
    static let cellIdentifier = String(describing: PullRequestCell.self)

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pullTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var username: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    //
    // MARK: - Cell Control Methods
    //

    func show(model: PullRequestsListModel.PullRequest) {
        userImageView.image = UIImage.placeholder
        descriptionLabel.text = model.body
        pullTitleLabel.text = model.title
        dateLabel.text = model.createdAt
        username.text = model.owner
    }

    func updateImage(_ image: UIImage?) {
        userImageView.image = image
    }

    private func setupImageView() {
        userImageView.layer.cornerRadius = userImageView.bounds.width / 2.0
        userImageView.layer.masksToBounds = true
    }
}
