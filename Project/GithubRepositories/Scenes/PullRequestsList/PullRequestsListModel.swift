import Foundation
import UIKit

/// The RecipeList scene model
final class PullRequestsListModel {
    private let pullRequestsListAdapter: PullRequestsListAdapter
    private let imageAdapter: ImageDownloadAdapter

    var onUpdate: ((State) -> Void)? = nil
    var onError: ((String) -> Void)? = nil

    var state: State {
        didSet {
            onUpdate?(state)
        }
    }

    init(
        state: State = State(pullRequests: [], isLoading: true),
        recipesListAdapter: PullRequestsListAdapter = PullRequestsListAdapter(owner: "", repository: ""),
        imageDownloadAdapter: ImageDownloadAdapter = ImageDownloadAdapter()
    ) {
        self.state = state
        self.pullRequestsListAdapter = recipesListAdapter
        self.imageAdapter = imageDownloadAdapter
    }

    //
    // MARK: - Model Handling Methods
    //

    func getPullRequests() {
        state = State(pullRequests: state.pullRequests, isLoading: true, error: nil)

        pullRequestsListAdapter.getPulls { [weak self] pulls, error in
            self?.state.isLoading = false
            if error != nil {
                self?.state.error = ModelError.genericError(message: "Fail to load recipes")
                return
            }

            self?.state.pullRequests = pulls
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
        var pullRequests: [PullRequest]
        var isLoading: Bool
        var error: ModelError?

        var isLoadingFirstPage: Bool {
            pullRequests.isEmpty && isLoading
        }
    }

    struct PullRequest: Decodable, Equatable {
        let title: String
        let createdAt: String
        let body: String
        let htmlUrl: String
        let owner: String
        let ownerAvatarUrl: String
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
extension PullRequestsListModel.PullRequest {
    static func fixture(
        title: String = "PullRequest",
        createdAt: String = "12/12/2020",
        body: String = "Its just a Pull Request",
        htmlUrl: String = "https://github.com",
        owner: String = "Somebody",
        ownerAvatarUrl: String = "https://github.com"
    ) -> Self {
        .init(
            title: title,
            createdAt: createdAt,
            body: body,
            htmlUrl: htmlUrl,
            owner: owner,
            ownerAvatarUrl: ownerAvatarUrl
        )
    }
}
#endif
