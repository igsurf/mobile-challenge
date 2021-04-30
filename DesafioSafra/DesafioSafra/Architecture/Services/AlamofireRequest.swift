//
//  RequestManager.swift
//  DesafioSafra
//
//  Created by Renato Ferraz on 30/04/21.
//

import Alamofire

enum ServiceError: Error{
    case emptyData
    case connectionError
    case apiError
    case limit
    
    var localizedDescription: String{
        switch self {
        case .apiError:
            return "Something went wrong."
        case .emptyData:
            return "Nothing was found, try again or change the filters."
        case .connectionError:
            return "Your phone is not connected, conecte it and try again."
        case .limit:
            return "Error limit request API."
        }
    }
}

class AlamofireRequest: RequestManager {
    func requestResponse(url: URL, method: HTTPMethods, parameters: [String : Any], headers: [String : String], completion: @escaping (HTTPURLResponse?, Result<Data, Error>)-> Void) {
        AF.request(url, method: method.alamofire, parameters: parameters, headers: HTTPHeaders(headers)).responseData { response in
            switch response.result {
            case .success(let data):
                guard let httpUrlResponse = response.response else {
                    completion(nil, .success(data))
                    return
                }
                completion(httpUrlResponse, .success(data))
            case .failure(let error):
                completion(nil, .failure(error))
            }
        }
    }
    
    func requestDecodable<T>(url: URL, method: HTTPMethods, parameters: [String : Any], headers: [String : String], completion: @escaping (Result<T, Error>) -> Void)  where T : Decodable {
        AF.request(url, method: method.alamofire, parameters: parameters, headers: HTTPHeaders(headers)).responseData { response in

            guard [200,201].contains(response.response?.statusCode) else {
                if [403].contains(response.response?.statusCode) {
                    completion(.failure(ServiceError.limit))
                }
                return
            }
            
            switch response.result {
            case .success(let data):
                do{
                    let object = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(object))
                }catch{
                    completion(.failure(ServiceError.apiError))
                }
            case .failure(_):
                debugPrint("Erro no response do alamofire")
                completion(.failure(ServiceError.emptyData))
            }
        }
    }
    
    internal func requestData(url: URL, method: HTTPMethods, parameters: [String : Any], headers: [String : String], completion: @escaping (Result<Data, Error>) -> Void) {
        AF.request(url, method: method.alamofire, parameters: parameters, headers: HTTPHeaders(headers)).responseData { response in
            switch response.result {
            case let .success(data):
                completion(.success(data))
            case .failure(_):
                debugPrint("Erro no response do alamofire")
                completion(.failure(ServiceError.emptyData))
            }
        }
    }
    
}
