//
//  AlamofireRequest.swift
//  DesafioSafra
//
//  Created by Renato Ferraz on 30/04/21.
//

import Foundation
import Alamofire

protocol RequestManager {
    
    func requestDecodable<T: Decodable>(url: URL, method: HTTPMethods, parameters: [String: Any], headers: [String: String], completion: @escaping(Result<T, Error>) -> Void)
    func requestData(url: URL, method: HTTPMethods, parameters: [String : Any], headers: [String : String], completion: @escaping (Result<Data, Error>) -> Void)
    func requestResponse(url: URL, method: HTTPMethods, parameters: [String : Any], headers: [String : String], completion: @escaping (HTTPURLResponse?, Result<Data, Error>)-> Void)
}

enum RequestManagerFactory {
    case alamofire
    
    func create() -> RequestManager {
        switch self {
        case .alamofire:
            return AlamofireRequest()
        }
        // Fazer para UrlSession
    }
}

enum HTTPMethods: String {
    case get
    case post
    
    var alamofire: Alamofire.HTTPMethod {
        switch self {
        case .get:
            return Alamofire.HTTPMethod.get
        case .post:
            return Alamofire.HTTPMethod.post
        }
    }
    // Fazer para URLSession
}
