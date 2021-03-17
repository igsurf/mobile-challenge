import UIKit

/// Cell for UITableView to show a recipe.
class RepositoryCell: UITableViewCell {
    static let cellIdentifier = String(describing: RepositoryCell.self)

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var username: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    //
    // MARK: - Cell Control Methods
    //

    func show(model: RepositoriesListModel.Repository) {
        nameLabel.text = model.name
        descriptionLabel.text = model.description
        forksLabel.text = model.forksCount
        starLabel.text = model.stargazersCount
        username.text = model.login
    }

    func updateImage(_ image: UIImage?) {
        userImageView.image = image
    }
}
