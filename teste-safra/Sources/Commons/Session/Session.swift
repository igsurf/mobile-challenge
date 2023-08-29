//
//  Session.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 11/04/21.
//

import Foundation

class Session {
    private static let kServiceTypeKey = "Service_type"

    static var service: ServicesProtocol {
        let bundle = Bundle(for: Session.self)
        let serviceType = bundle.object(forInfoDictionaryKey: kServiceTypeKey) as? String
        switch serviceType {
        case ServiceType.mock.rawValue:
            return MockServices()
        case ServiceType.services.rawValue:
            return Services()
        default:
            return Services()
        }
    }
}
