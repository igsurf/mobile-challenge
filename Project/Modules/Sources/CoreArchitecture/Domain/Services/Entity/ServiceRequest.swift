import Foundation
import CoreInterfaces

struct ServiceRequest: ServiceRequestEntity {
    var url: String
    var method: ServiceMethod
    var body: ServiceBody?
    var headers: ServiceHeaders
    var timeout: TimeInterval
}
