//
//  NetworkingManager.swift
//  mobile-challenger
//
//  Created by Leonardo Sugano on 20/02/21.
//

import Foundation
import AFNetworking
import Mantle

class NetworkingManager {
    //MARK: - Vars
    
    //MARK: - Lets
    let manager = AFHTTPSessionManager()
    let repositoriesURL = "https://api.github.com/search/repositories"
    let apiBasePullRequest = "https://api.github.com/repos/"

    //MARK: - Functions
    func getRepositories(page: Int, success:@escaping (_ success:[RepositoriesModel]) -> Void, error:@escaping(_ error: String) -> Void) {
        let parameters: [String : Any]  = [
            "q" : "language:Java",
            "sort" : "stars",
            "page" : page
        ]
        
        manager.get(repositoriesURL, parameters: parameters, progress: nil) { (operation, responseObject) in
            
            if let response = responseObject as? [String:Any], let responseDict = response["items"] as? NSArray {
                let responseArray: NSMutableArray = []
                
                for item in responseDict {
                    guard let model = try? MTLJSONAdapter.model(of: RepositoriesModel.self, fromJSONDictionary: item as? [AnyHashable : Any]) else {
                        return
                    }
                    responseArray.add(model)
                }
                
                if let successResponse = responseArray as? [RepositoriesModel] {
                    success(successResponse)
                }
            }
        } failure: { (operation, errorMessage) in
            error(errorMessage.localizedDescription)
        }
    }
    
    
    func getPullRequest(page: Int, nameUrl: String, success:@escaping (_ success:[PullRequestModel]) -> Void, error:@escaping(_ error: String) -> Void) {
        
        let parameters: [String : Any]  = [
            "state" : "all",
            "page" : page
        ]
        
        let url = String(format: "%@%@/pulls", apiBasePullRequest, nameUrl)
        
        manager.get(url, parameters: parameters, progress: nil) { (operation, responseObject) in
            if let response = responseObject as? NSArray {
                let responseArray: NSMutableArray = []
                
                for item in response {
                    guard let model = try? MTLJSONAdapter.model(of: PullRequestModel.self, fromJSONDictionary: item as? [AnyHashable : Any]) else {
                        return success([])
                    }
                    responseArray.add(model)
                }
                
                if let successResponse = responseArray as? [PullRequestModel] {
                    success(successResponse)
                }
            }
            
        } failure: { (operation, errorMessage) in
            error(errorMessage.localizedDescription)
        }
    }
}
