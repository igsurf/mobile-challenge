public protocol RepositoriesService {
    func getRepositories(page: Int,
                         onCompletion: (([Repository]) -> Void)?,
                         onError: ((Error) -> Void)?)
}
