import CoreInterfaces

public enum PullRequestsServiceProvider {
    public static func `default`(pageSize: Int) -> PullRequestsService {
        return PullRequestsServiceWorker(pageSize: pageSize)
    }
}
