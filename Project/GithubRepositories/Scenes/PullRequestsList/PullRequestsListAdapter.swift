import CoreArchitecture
import CoreInterfaces
import Foundation

final class PullRequestsListAdapter {
    let service: PullRequestsService
    private var page: Int = 1
    private var owner: String
    private var repository: String

    init(
        owner: String,
        repository: String,
        service: PullRequestsService = PullRequestsServiceProvider.default(pageSize: 40)
    ) {
        self.owner = owner
        self.repository = repository
        self.service = service
    }

    func getPulls(completion: @escaping ([PullRequestsListModel.PullRequest], Error?) -> Void) {
        let currentPage = page

        service.getPullRequests(
            in: repository,
            owner: owner,
            page: currentPage,
            onCompletion: { [weak self] recipes in
                let recipesList = recipes.map(PullRequestsListModel.PullRequest.init)
                self?.page = currentPage + 1
                completion(recipesList, nil)
            },

            onError: { error in
                completion([], error)
            }
        )
    }
}

private extension PullRequestsListModel.PullRequest {
    init(from pull: PullRequest) {
        self.init(
            title: pull.title,
            createdAt: pull.createdAt,
            body: pull.body,
            htmlUrl: pull.htmlUrl,
            owner: pull.user.login,
            ownerAvatarUrl: pull.user.avatarUrl ?? ""
        )
    }
}
