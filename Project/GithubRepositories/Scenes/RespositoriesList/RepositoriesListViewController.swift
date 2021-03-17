import UIKit

/// Recipes List scene ViewController
final class RepositoriesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let dependencies = RepositoriesListDependencies.default()
    private var model: RepositoriesListModel!
    private var tableHandler: RepositoriesTableViewHandler?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        model = dependencies.model()
    }

    //
    // MARK: - ViewController Life cycle
    //

    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
        bindings()
        model.getRepositories()
    }

    //
    // MARK: - Helpers
    //

    private func bindings() {
        model.onUpdate = { state in
            DispatchQueue.main.async { [weak self] in
                self?.tableHandler?.update(
                    recipes: state.repositories,
                    isLoading: state.isLoading,
                    errorMessage: state.error?.errorDescription
                )
            }
        }

        tableHandler?.onSelectRecipe = { repository in
            self.showPullRequests(repository: repository)
        }

        tableHandler?.onNeedImageUpdate = { recipe, indexPath in
            self.updateCellImage(for: recipe, at: indexPath)
        }

        tableHandler?.onRetry = {
            self.model.getRepositories()
        }
    }

    private func updateCellImage(for repository: RepositoriesListModel.Repository, at indexPath: IndexPath) {
        model.getImage(at: repository.avatarUrl) { image in
            DispatchQueue.main.async { [weak self] in
                self?.tableHandler?.updateImage(image, at: indexPath)
            }
        }
    }

    private func setupComponents() {
        tableHandler = .init(tableView: tableView)
    }


    private func showPullRequests(repository: RepositoriesListModel.Repository) {
        let owner = repository.login
        let name = repository.name
        let segue = "pullrequests"

        let dependencies = PullRequestsListDependencies.default(
            owner: owner,
            repository: name,
            pageSize: 40
        )

        performSegue(withIdentifier: segue, sender: dependencies)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PullRequestsListViewController,
           let dependencies = sender as? PullRequestsListDependencies {
            destination.dependencies = dependencies
        }
    }
}
