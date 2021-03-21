//
//  NetworkRequest.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 21/02/21.
//

import Foundation
import Alamofire

protocol NetworkMethods {
    func get(url: String, headers: HTTPHeaders?, completion: @escaping (Any) -> Void)
}

public class NetworkRequest: NetworkMethods {
    public static let instance: NetworkRequest = NetworkRequest()
    
    private init() {
    }
    
    func get(url: String, headers: HTTPHeaders?, completion: @escaping (Any) -> Void) {
        self.request(url: self.asURL(url), method: HTTPMethod.get, parameters: nil, headers: headers, completion: completion)
    }

    private func request(url: URLConvertible, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, completion: @escaping (Any) -> Void) {
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let json):
                completion(json)
                break
            case .failure(let error):
                RGLog.e(error.localizedDescription)
                break
            }
        })
    }
    
    private func asURL(_ sUrl: String) -> URLConvertible {
        guard let url = URL(string: sUrl) else {
            fatalError("Erro ao criar URL: \(sUrl)")
        }
        return url
    }
}
