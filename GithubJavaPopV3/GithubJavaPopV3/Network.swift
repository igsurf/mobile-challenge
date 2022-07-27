//
//  Network.swift
//  GithubJavaPopV3
//
//  Created by Suh on 08/07/22.
//

import Foundation

class Network {
    
    private let session: URLSession
    static var shared: Network {
        if instance == nil {
            instance = Network()
        }
        return instance!
    }
    
    static private var instance: Network?
    //Alternative
    //static let shared = Network()
    
    private init() {
        session = URLSession.shared
    }
    
    func requestData(
        using request: RequestProtocol,
        onComplete: @escaping (Data) -> Void,
        onError: @escaping (Error) -> Void
    ) {
        guard let url = URL(string: request.baseURL + request.path) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        let datatask = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                onError(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                let error = NSError(domain: "Response fail", code: 499, userInfo: nil)
                onError(error)
                return
            }
            
            guard response.statusCode >= 200 && response.statusCode < 300 else {
                let error = NSError(domain: "Unexpected fail", code: response.statusCode, userInfo: nil)
                onError(error)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "No Data", code: 499, userInfo: nil)
                onError(error)
                return
            }
            
            onComplete(data)
            
        }
        datatask.resume()
    }

}
