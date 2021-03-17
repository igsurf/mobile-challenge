public protocol PullRequestsService {
    func getPullRequests(in repository: String,
                         owner: String,
                         page:Int,
                         onCompletion: (([PullRequest]) -> Void)?,
                         onError: ((Error) -> Void)?)
}
