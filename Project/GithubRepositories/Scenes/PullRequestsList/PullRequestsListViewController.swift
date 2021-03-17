import UIKit
import SafariServices

/// Recipes List scene ViewController
final class PullRequestsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var dependencies: PullRequestsListDependencies = .default(owner: "", repository: "", pageSize: 40) {
        didSet {
            model = dependencies.model()
        }
    }

    private var model: PullRequestsListModel!
    private var tableHandler: PullRequestsTableViewHandler?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    //
    // MARK: - ViewController Life cycle
    //

    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
        bindings()
        model.getPullRequests()
    }

    //
    // MARK: - Helpers
    //

    private func bindings() {
        model.onUpdate = { state in
            DispatchQueue.main.async { [weak self] in
                self?.tableHandler?.update(
                    pullRequests: state.pullRequests,
                    isLoading: state.isLoading,
                    errorMessage: state.error?.errorDescription
                )
            }
        }

        tableHandler?.onSelectRecipe = { [weak self] pull in
            self?.showPullRequest(pull: pull)
        }

        tableHandler?.onNeedImageUpdate = { recipe, indexPath in
            self.updateCellImage(for: recipe, at: indexPath)
        }

        tableHandler?.onRetry = {
            self.model.getPullRequests()
        }
    }

    private func updateCellImage(for pull: PullRequestsListModel.PullRequest, at indexPath: IndexPath) {
        model.getImage(at: pull.ownerAvatarUrl) { image in
            DispatchQueue.main.async { [weak self] in
                self?.tableHandler?.updateImage(image, at: indexPath)
            }
        }
    }

    private func setupComponents() {
        tableHandler = .init(tableView: tableView)
    }

    private func showPullRequest(pull: PullRequestsListModel.PullRequest) {
        if let url = URL(string: pull.htmlUrl) {
            let viewController = SFSafariViewController(url: url)
            present(viewController, animated: true, completion: nil)
        }
    }
}
