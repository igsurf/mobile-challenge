import CoreInterfaces
import Foundation

final class RawDataDownloaderWorker: RawDataDownloadeService {
    private let requestService: RequestServicePort

    init(service: RequestServicePort = RequestServiceAdapter()) {
        self.requestService = service
    }

    func getData(from url: String,
                 onCompletion: ((Data) -> Void)?,
                 onError: ((Error) -> Void)?) {

        let request = ServiceRequest(url: url,
                                     method: .get,
                                     body: nil,
                                     headers: [:],
                                     timeout: Config.requestTimeout)

        requestService.requestData(from: request, interceptor: nil, additionalHeaders: [:], completion: { result in
            switch result {
            case let .success(data):
                onCompletion?(data)
            case let .failure(err):
                onError?(err)
            }
        })
    }
}
