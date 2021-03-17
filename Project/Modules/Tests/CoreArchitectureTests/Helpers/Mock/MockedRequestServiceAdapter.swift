@testable import CoreArchitecture
import CoreInterfaces
import XCTest

class MockedRequestServiceAdapter: RequestServicePort {

    let fixtureData: Data
    let error: Error!
    let decoder: JSONDecoder

    init(data: Data, decoder: JSONDecoder = RequestServiceAdapter.generateDecoder(from: nil)) {
        self.fixtureData = data
        self.error = nil
        self.decoder = decoder
    }

    init(error: Error) {
        self.fixtureData = Data(capacity: 0)
        self.error = error
        decoder = JSONDecoder()
    }

    func requestData(from request: ServiceRequestEntity,
                     interceptor: RequestInterceptor?,
                     additionalHeaders: ServiceHeaders,
                     completion: ServiceCompletion?) {

        if error != nil {
            completion?(.failure(error))
            return
        }

        completion?(.success(fixtureData))

    }

    func request<T>(_ type: T.Type,
                    from request: ServiceRequestEntity,
                    interceptor: RequestInterceptor?,
                    additionalHeaders: ServiceHeaders,
                    completion: DecodedCompletion<T>?) where T : Decodable {

        let decoder = self.decoder

        requestData(from: request,
                    interceptor: interceptor,
                    additionalHeaders: additionalHeaders) { result in
            switch result {
            case .failure(let err):
                let failResult: DecodedResult<T> = .failure(err)
                completion?(failResult)
            case .success(let data):
                let object = try! decoder.decode(T.self, from: data)
                let successResult: DecodedResult<T> = .success(object)
                completion?(successResult)
            }
        }
    }
}


