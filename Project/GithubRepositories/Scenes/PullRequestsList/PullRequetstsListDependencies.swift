import Foundation
import CoreArchitecture

struct PullRequestsListDependencies {
    var model: () -> PullRequestsListModel
    var pageSize: Int

    private init(
        pageSize: Int,
        model: @escaping () -> PullRequestsListModel
    ) {
        self.model = model
        self.pageSize = pageSize
    }
}

extension PullRequestsListDependencies {
    static func `default`(
        owner: String,
        repository: String,
        pageSize: Int
    ) -> Self {
        return self.init(
            pageSize: pageSize,

            model: {
                let state = PullRequestsListModel.State(pullRequests: [], isLoading: true, error: nil)
                let adapter = PullRequestsListAdapter(
                    owner: owner,
                    repository: repository,
                    service: PullRequestsServiceProvider.default(pageSize: pageSize)
                )
                
                let imageDownloader = ImageDownloadAdapter()
                return PullRequestsListModel(state: state, recipesListAdapter: adapter, imageDownloadAdapter: imageDownloader)
            }
        )
    }

    static func mock() -> Self {
        return Self.default(owner: "Alamofire", repository: "Alamifire", pageSize: 40)
    }
}
