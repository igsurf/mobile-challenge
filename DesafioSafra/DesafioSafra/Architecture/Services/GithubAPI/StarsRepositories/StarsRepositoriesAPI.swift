//
//  StarsRepositoriesAPI.swift
//  DesafioSafra
//
//  Created by Renato Ferraz on 30/04/21.
//

import Foundation
import Alamofire

class StarsRepositoriesAPI {
     
    private let manager: RequestManager
    
    init(manager: RequestManager) {
        self.manager = manager
    }
    
    @available(iOS 13.0, *)
    func getStarsRepos(link: String, completion: @escaping (Result<JavaPop,Error>, String?)->Void) {
        let urlString = GithubAPISources.starsRepositoriesPagination(urlString: link).getURL()
        var nextLink: String?
        
        switch urlString {
        case .success(let url):
            manager.requestResponse(url: url, method: .get, parameters: [:], headers: [:]) { response, data in
                guard let response = response else {
                    completion(.failure(ServiceError.apiError),nil)
                    return
                }
                
                switch data {
                case .success(let data):
                    if let linkHeader = response.value(forHTTPHeaderField: "Link"){
                        nextLink = self.parseLinkHeader(linkHeader: linkHeader)["rel=\"next\""]
                    }
                    do{
                        let object = try JSONDecoder().decode(JavaPop.self, from: data)
                        completion(.success(object),nextLink)
                    }catch{
                        completion(.failure(ServiceError.apiError),nil)
                    }
                case .failure(let error):
                    completion(.failure(error), nil)
                }
            }
        case .failure(let error):
            completion(.failure(error),nil)
        }
    }
    
    
    private func parseLinkHeader(linkHeader: String) -> [String:String] {
        let links = linkHeader.components(separatedBy: ",")

        var dictionary: [String: String] = [:]
        links.forEach({
            let components = $0.components(separatedBy:"; ")
            let cleanPath = components[0].trimmingCharacters(in: CharacterSet(charactersIn: "<>"))
            let cleanPathSpaces = cleanPath.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: "<", with: "")
            dictionary[components[1]] = cleanPathSpaces
        })

        return dictionary
    }
    
}
