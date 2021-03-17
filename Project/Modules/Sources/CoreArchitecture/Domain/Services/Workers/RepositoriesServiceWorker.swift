import CoreInterfaces

final class RepositoriesServiceWorker: RepositoriesService {

    private let requestService: RequestServicePort
    private let interceptor: RequestInterceptor

    init(service: RequestServicePort = RequestServiceAdapter(),
         interceptor: RequestInterceptor = DefaultInterceptor()) {
        self.requestService = service
        self.interceptor = interceptor
    }

    func getRepositories(page: Int,
                         onCompletion: (([Repository]) -> Void)?,
                         onError: ((Error) -> Void)?) {

        requestService.request([Repository].self,
                               from: makeRequest(),
                               interceptor: interceptor,
                               additionalHeaders: [:]) { result in
            switch result {
            case let .failure(error):
                onError?(error)
            case let .success(repositories):
                onCompletion?(repositories)
            }
        }
    }

    private func makeRequest(language: String = "Java", page:Int = 1) -> ServiceRequest {
        let urlPath = Config.baseURL + "/repositories?q=\(language):Java&sort=stars&page=\(page)"

        let request = ServiceRequest(url: urlPath,
                                     method: .get,
                                     body: nil,
                                     headers: [:],
                                     timeout: Config.requestTimeout)

        return request
    }
}
