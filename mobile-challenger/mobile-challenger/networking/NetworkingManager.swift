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
    
    //MARK: - Functions
    func getRepositories(page: Int, success:@escaping (_ success:[RepositoriesModel]) -> Void, error:(_ error: String) -> Void) {
        let parameters: [String : Any]  = [
            "q" : "language:Java",
            "sort" : "stars",
            "page" : page
        ]
        
        manager.get(repositoriesURL, parameters: parameters) { (inProgress) in
                
        } success: { (operation, responseObject) in
            
            if let response = responseObject as? [String:Any], let responseDict = response["items"] as? NSArray {
                let responseArray: NSMutableArray = []
                
                for item in responseDict {
                    guard let model = try? MTLJSONAdapter.model(of: RepositoriesModel.self, fromJSONDictionary: item as? [AnyHashable : Any]) else {
                        return
                    }
                    responseArray.add(model)
                }
                
                //funcionou a parte do array responder, vitoria cantou, parte 1
                if let successResponse = responseArray as? [RepositoriesModel] {
                    success(successResponse)
                }
            }
            

        } failure: { (operation, error) in
            print(error)
        }
        
        


    }
    
    func getPullRequest() {
        
    }
}
