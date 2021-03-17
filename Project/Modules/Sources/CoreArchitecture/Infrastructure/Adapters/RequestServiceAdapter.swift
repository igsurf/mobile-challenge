import DDXNetwork
import Foundation
import CoreInterfaces

final class RequestServiceAdapter: RequestServicePort {
    private let http: HttpService
    private var decoder: JSONDecoder
    private let interceptor: RequestInterceptor?

    init(decoder: JSONDecoder? = nil,
         interceptor: RequestInterceptor? = nil,
         http: HttpService = HttpWorker()) {

        self.http = http
        self.interceptor = interceptor
        self.decoder = RequestServiceAdapter.generateDecoder(from: decoder)
    }

    func requestData(from request: ServiceRequestEntity,
                     interceptor: RequestInterceptor?,
                     additionalHeaders: ServiceHeaders,
                     completion: ServiceCompletion?) {

        http.request(request,
                     additionalHeaders: additionalHeaders,
                     completion: completion)
    }

    func request<T: Decodable>(_ type: T.Type,
                               from request: ServiceRequestEntity,
                               interceptor: RequestInterceptor?,
                               additionalHeaders: ServiceHeaders = [:],
                               completion: DecodedCompletion<T>?) {

        let interceptedRequest = interceptor?.intercept(request: request) ?? request

        http.request(interceptedRequest, additionalHeaders: additionalHeaders) { dataResult in
            switch dataResult {
            case .failure(let error):
                completion?(.failure(error))

            case .success(let data):
                do {
                    let decodedObject = try self.decoder.decode(type, from: data)
                    completion?(.success(decodedObject))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
    }

    static func generateDecoder(from decoder: JSONDecoder?) -> JSONDecoder {
        if let jsonDecoder = decoder {
            return jsonDecoder
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

