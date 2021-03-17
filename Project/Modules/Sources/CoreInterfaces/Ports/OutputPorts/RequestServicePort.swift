import Foundation
import DDXNetwork

public typealias ServiceRequestEntity = RequestModel
public typealias ServiceHeaders = HttpHeaders
public typealias ServiceBody = HttpBody
public typealias ServiceMethod = HttpMethod

public typealias ServiceResult = Result<Data, Error>
public typealias ServiceCompletion = (HttpResult) -> Void

public protocol RequestInterceptor {
    func intercept(request: ServiceRequestEntity) -> ServiceRequestEntity
}

public protocol RequestServicePort {
    func requestData(from request: ServiceRequestEntity,
                     interceptor: RequestInterceptor?,
                     additionalHeaders: ServiceHeaders,
                     completion: ServiceCompletion?)

    func request<T: Decodable>(_ type: T.Type,
                               from request: ServiceRequestEntity,
                               interceptor: RequestInterceptor?,
                               additionalHeaders: ServiceHeaders,
                               completion: DecodedCompletion<T>?)
}

