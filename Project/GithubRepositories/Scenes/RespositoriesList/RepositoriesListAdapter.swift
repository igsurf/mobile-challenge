import CoreArchitecture
import CoreInterfaces
import Foundation

final class RepositoriesListAdapter {
    let service: RepositoriesService
    private var page: Int = 0

    init(service: RepositoriesService = RepositoriesServiceProvider.default()) {
        self.service = service
    }

    func getRecipes(completion: @escaping ([RepositoriesListModel.Repository], Error?) -> Void) {
        service.getRepositories(
            page: page,
            onCompletion: { recipes in
                let recipesList = recipes.map(RepositoriesListModel.Repository.init)
                completion(recipesList, nil)
            },

            onError: { error in
                completion([], error)
            }
        )
    }
}

private extension RepositoriesListModel.Repository {
    init(from repository: Repository) {
        self.init(
            id: repository.id,
            name: repository.name,
            description: repository.description ?? "",
            forksCount: String(repository.forksCount ?? 0),
            stargazersCount: String(repository.stargazersCount ?? 0),
            login: repository.owner?.login ?? "",
            avatarUrl: repository.owner?.avatarUrl ?? ""
        )
    }
}
