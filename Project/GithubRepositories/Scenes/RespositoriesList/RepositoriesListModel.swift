import Foundation
import UIKit

/// The RecipeList scene model
final class RepositoriesListModel {
    private let repositoriesListAdapter: RepositoriesListAdapter
    private let imageAdapter: ImageDownloadAdapter

    var onUpdate: ((State) -> Void)? = nil
    var onError: ((String) -> Void)? = nil

    var state: State {
        didSet {
            onUpdate?(state)
        }
    }

    init(
        state: State = State(repositories: [], isLoading: true),
        recipesListAdapter: RepositoriesListAdapter = RepositoriesListAdapter(),
        imageDownloadAdapter: ImageDownloadAdapter = ImageDownloadAdapter()
    ) {
        self.state = state
        self.repositoriesListAdapter = recipesListAdapter
        self.imageAdapter = imageDownloadAdapter
    }

    //
    // MARK: - Model Handling Methods
    //

    func getRepositories() {
        state = State(repositories: state.repositories, isLoading: true, error: nil)

        repositoriesListAdapter.getRecipes { [weak self] repositories, error in
            self?.state.isLoading = false
            if error != nil {
                self?.state.error = ModelError.genericError(message: "Fail to load recipes")
                return
            }

            self?.state.repositories = repositories
        }
    }

    func getImage(at urlPath: String?, completion: @escaping (UIImage?) -> Void) {
        imageAdapter.getImage(from: urlPath) { image, _ in
            var resultImage = UIImage.placeholder

            if let image = image {
                resultImage = image
            }

            completion(resultImage)
        }
    }

    //
    // MARK: - Model Entities
    //

    struct State {
        var repositories: [Repository]
        var isLoading: Bool
        var error: ModelError?

        var isLoadingFirstPage: Bool {
            repositories.isEmpty && isLoading
        }
    }

    struct Repository: Decodable, Equatable {
        let id: Int
        let name: String
        let description: String
        let forksCount: String
        let stargazersCount: String
        let login: String
        let avatarUrl: String?
    }

    enum ModelError: Error, LocalizedError {
        case genericError(message: String)

        var errorDescription: String? {
            switch self {
            case let .genericError(message: errorMessage):
                return errorMessage
            }
        }
    }
}

#if DEBUG
extension RepositoriesListModel.Repository {
    static func fixture(
        id: Int,
        name: String = "Repository",
        description: String = "Just a repository",
        forksCount: String = "12",
        stargazersCount: String = "10",
        login: String = "logged_user",
        avatarUrl: String? = "my_avatar"
    ) -> Self {
        .init(
            id: id,
            name: name,
            description: description,
            forksCount: forksCount,
            stargazersCount: stargazersCount,
            login: login,
            avatarUrl: avatarUrl
        )
    }
}
#endif
