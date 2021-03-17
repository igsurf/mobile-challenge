import UIKit

class RepositoriesTableViewHandler: NSObject, UITableViewDataSource, UITableViewDelegate {
    typealias Repository = RepositoriesListModel.Repository
    private let tableView: UITableView

    private var recipes: [Repository] = []
    private var isLoading: Bool = false
    private var errorMessage: String?

    /// This closure sends a signal everytime a recipe cell demands an image download.
    var onNeedImageUpdate: ((Repository, IndexPath) -> Void)?

    /// This closure sends a signal to select of deselect a recipe.
    var onSelectRecipe: ((Repository) -> Void)?

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
        regiserCell(identifier: RepositoryCell.cellIdentifier)
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

        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if shouldShowRecipes {
            let recipe = recipes[indexPath.row]
            return createRecipeCell(using: recipe, at: indexPath)
        }

        if errorMessage != nil{
            return createErrorCell(at: indexPath)
        }

        return createLoadingCell(at: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelectRecipe?(recipes[indexPath.row])
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == recipes.count - 1 {
            onReachEndOfList?()
        }
    }

    //
    // MARK: - Cell Creation Helpers
    //

    func createRecipeCell(using recipe: Repository, at indexPath: IndexPath) -> RepositoryCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.cellIdentifier) as? RepositoryCell else {
            fatalError("RecipeCell not found")
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
            let cell = tableView.cellForRow(at: indexPath) as? RepositoryCell
            cell?.updateImage(image)
        }
    }

    func update(recipes:[RepositoriesListModel.Repository], isLoading: Bool = false, errorMessage: String?) {
        self.errorMessage = errorMessage
        self.isLoading = isLoading
        self.recipes = recipes
        tableView.reloadData()
    }
}
