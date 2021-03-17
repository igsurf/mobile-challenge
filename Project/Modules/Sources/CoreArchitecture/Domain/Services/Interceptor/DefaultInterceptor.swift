import CoreInterfaces

struct DefaultInterceptor: RequestInterceptor {
    func intercept(request: ServiceRequestEntity) -> ServiceRequestEntity {

        var headers = request.headers

        for (header, value) in Config.defaultHeaders {
            headers[header] = value
        }

        return ServiceRequest(url: request.url,
                              method: request.method,
                              body: request.body,
                              headers: headers,
                              timeout: request.timeout
        )
    }
}
