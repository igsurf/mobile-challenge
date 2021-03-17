import Foundation

struct RepositoriesListDependencies {
    var model: () -> RepositoriesListModel

    private init(model: @escaping () -> RepositoriesListModel) {
        self.model = model
    }
}

extension RepositoriesListDependencies {
    static func `default`() -> Self {
        .init { () -> RepositoriesListModel in
            let state = RepositoriesListModel.State(repositories: [], isLoading: true, error: nil)
            let adapter = RepositoriesListAdapter()
            let imageDownloader = ImageDownloadAdapter()
            return RepositoriesListModel(state: state, recipesListAdapter: adapter, imageDownloadAdapter: imageDownloader)
        }
    }
}
