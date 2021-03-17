import CoreInterfaces

final class PullRequestsServiceWorker: PullRequestsService {

    private let requestService: RequestServicePort
    private let interceptor: RequestInterceptor
    private let pageSize: Int

    init(service: RequestServicePort = RequestServiceAdapter(),
         interceptor: RequestInterceptor = DefaultInterceptor(),
         pageSize: Int = 40) {
        self.requestService = service
        self.interceptor = interceptor
        self.pageSize = pageSize
    }

    func getPullRequests(in repository: String,
                         owner: String,
                         page: Int,
                         onCompletion: (([PullRequest]) -> Void)?,
                         onError: ((Error) -> Void)?) {

        requestService.request([PullRequest].self,
                               from: makeRequest(repository: repository,
                                                 owner: owner,
                                                 pageSize: pageSize,
                                                 page: page),
                               interceptor: interceptor,
                               additionalHeaders: [:]) { result in
            switch result {
            case let .failure(error):
                onError?(error)
            case let .success(pulls):
                onCompletion?(pulls)
            }
        }
    }

    private func makeRequest(repository:String, owner:String, pageSize:Int, page:Int) -> ServiceRequest {
        let urlPath = Config.baseURL + "/repos/\(owner)/\(repository)/pulls?per_page=\(pageSize)&page=\(page)"

        let request = ServiceRequest(url: urlPath,
                                     method: .get,
                                     body: nil,
                                     headers: [:],
                                     timeout: Config.requestTimeout)

        return request
    }
}
