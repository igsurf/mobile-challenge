//
//  RepositoriesModelTest.swift
//  mobile-challengerTests
//
//  Created by Leonardo Sugano on 21/02/21.
//

import XCTest

@testable import mobile_challenger
import AFNetworking
import Mantle
import Quick
import Nimble
import UIKit

class RepositoriesModelTest: QuickSpec {
    
    let convertDict: NSDictionary = [
        "repositoryName" : "CS-Notes",
        "descriptionRepository" : ":books: 技术面试必备基础知识、Leetcode、计算机操作系统、计算机网络、系统设计、Java、Python、C++",
        "ownerProfile" : "https://api.github.com/users/CyC2018",
        "ownerUsername" : "CyC2018",
        "ownerImage" : "https://avatars.githubusercontent.com/u/36260787?v=4",
        "starsCount" : 121329,
        "forksCount" : 39380,
        "fullName" : "CyC2018/CS-Notes"
    ]
    
    let dict: NSDictionary = [
        "name" : "CS-Notes",
        "description" : ":books: 技术面试必备基础知识、Leetcode、计算机操作系统、计算机网络、系统设计、Java、Python、C++",
        "owner.url" : "https://api.github.com/users/CyC2018",
        "owner.login" : "CyC2018",
        "owner.avatar" : "https://avatars.githubusercontent.com/u/36260787?v=4",
        "stargazers_count" : 121329,
        "forks_count" : 39380,
        "full_name" : "CyC2018/CS-Notes"
    ]
    
    override func spec() {
        describe("RepositoriesModel") {
            it("test convert dictionary") {
                
//                if let self.dict as? [AnyHashable : Any] {
//
//                }
//
//
//                let model = try? MTLJSONAdapter.model(of: RepositoriesModel.self, fromJSONDictionary: self.myDict as? [AnyHashable : Any])
//                expect(model).toNot(beNil())
                
            }
        }
    }
}
