import UIKit

class PullRequestsTableViewHandler: NSObject, UITableViewDataSource, UITableViewDelegate {
    typealias PullRequest = PullRequestsListModel.PullRequest
    private let tableView: UITableView

    private var pulls: [PullRequest] = []
    private var isLoading: Bool = false
    private var errorMessage: String?

    /// This closure sends a signal everytime a recipe cell demands an image download.
    var onNeedImageUpdate: ((PullRequest, IndexPath) -> Void)?

    /// This closure sends a signal to select of deselect a recipe.
    var onSelectRecipe: ((PullRequest) -> Void)?

    /// This closure sends a signal to reload recipes. Only called in case of fail.
    var onRetry: (() -> Void)?

    /// This closure sends a signal to get mor elements
    var onReachEndOfList: (() -> Void)?

    var shouldShowRecipes: Bool {
        errorMessage == nil && isLoading == false
    }

    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        setupTableView()
    }

    //
    // MARK: - Helpers
    //

    private func setupTableView() {
        regiserCell(identifier: PullRequestCell.cellIdentifier)
        regiserCell(identifier: LoadingCell.cellIdentifier)
        regiserCell(identifier: ErrorCell.cellIdentifier)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
    }

    private func regiserCell(identifier: String) {
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }

    //
    // MARK: - TableView Delegate, Datasource
    //

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let justOne = 1

        if shouldShowRecipes == false {
            return justOne
        }

        return pulls.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if shouldShowRecipes {
            let pull = pulls[indexPath.row]
            return createPullRequestCell(using: pull, at: indexPath)
        }

        if errorMessage != nil {
            return createErrorCell(at: indexPath)
        }

        return createLoadingCell(at: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelectRecipe?(pulls[indexPath.row])
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == pulls.count - 1 {
            onReachEndOfList?()
        }
    }

    //
    // MARK: - Cell Creation Helpers
    //

    func createPullRequestCell(using recipe: PullRequest, at indexPath: IndexPath) -> PullRequestCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PullRequestCell.cellIdentifier) as? PullRequestCell else {
            fatalError("PullRequestCell not found")
        }

        cell.selectionStyle = .none
        cell.show(model: recipe)
        onNeedImageUpdate?(recipe, indexPath)
        return cell
    }

    func createLoadingCell(at indexPath: IndexPath) -> LoadingCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.cellIdentifier) as? LoadingCell else {
            fatalError("LoadingCell not found")
        }

        cell.selectionStyle = .none
        return cell
    }

    func createErrorCell(at indexPath: IndexPath) -> ErrorCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ErrorCell.cellIdentifier) as? ErrorCell else {
            fatalError("ErrorCell not found")
        }

        cell.selectionStyle = .none
        cell.messageLabel.text = errorMessage
        cell.onCallRetry = { [weak self] in self?.onRetry?() }
        return cell
    }

    //
    // MARK: - TableHandler updating methods
    //

    func updateImage(_ image: UIImage?, at indexPath: IndexPath) {
        let visiblePaths = tableView.indexPathsForVisibleRows ?? []
        if visiblePaths.contains(indexPath) {
            let cell = tableView.cellForRow(at: indexPath) as? PullRequestCell
            cell?.updateImage(image)
        }
    }

    func update(pullRequests:[PullRequestsListModel.PullRequest], isLoading: Bool = false, errorMessage: String?) {
        self.errorMessage = errorMessage
        self.isLoading = isLoading
        self.pulls = pullRequests
        tableView.reloadData()
    }
}
