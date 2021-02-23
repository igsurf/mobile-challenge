//
//  ModelsMock.swift
//  mobile-challengerTests
//
//  Created by Leonardo Sugano on 21/02/21.
//

import UIKit
@testable import mobile_challenger

class ModelsMock {
    static func setPullRequestMockResponse() -> [PullRequestModel] {
        var mutable = [PullRequestModel]()
        
        let first : NSDictionary = [
            "urlPR" : "https://github.com/CyC2018/CS-Notes/pull/1052",
            "titlePR" : "Update 57.1 和为 S 的两个数字.md",
            "descriptionPR" : "L23:    int cur = nums[i] + array[j]; \r\nThis should be：\r\nL23:    int cur = nums[i] + nums[j];",
            "ownerUsername" : "zhu956645239",
            "ownerImage" : "https://avatars.githubusercontent.com/u/38211259?v=4",
            "createDate" : "2021-02-20T05:48:54Z",
            "state" : "open"
        ]
        
        let second : NSDictionary = [
            "urlPR" : "https://api.github.com/repos/CyC2018/CS-Notes/pulls/1050",
            "titlePR" : "Update 57.1 和为 S 的两个数字.md",
            "descriptionPR" : "L23:    int cur = nums[i] + array[j]; \r\nThis should be：\r\nL23:    int cur = nums[i] + nums[j];",
            "ownerUsername" : "zhu956645239",
            "ownerImage" : "https://avatars.githubusercontent.com/u/38211259?v=4",
            "createDate" : "2021-02-20T05:48:54Z",
            "state" : "closed"
        ]

        if let dict = first as? [AnyHashable : Any], let mock = try? PullRequestModel(dictionary: dict) {
            mutable.append(mock)
        }
            
        if let dict = second as? [AnyHashable : Any], let mock = try? PullRequestModel(dictionary: dict) {
            mutable.append(mock)
        }
        
        return mutable
    }
    
    static func setGetRepositoriesMockResponse() -> [RepositoriesModel] {
        let myDict: NSDictionary = [
            "repositoryName" : "CS-Notes",
            "descriptionRepository" : ":books: 技术面试必备基础知识、Leetcode、计算机操作系统、计算机网络、系统设计、Java、Python、C++",
            "ownerProfile" : "https://api.github.com/users/CyC2018",
            "ownerUsername" : "CyC2018",
            "ownerImage" : "https://avatars.githubusercontent.com/u/36260787?v=4",
            "starsCount" : 121329,
            "forksCount" : 39380,
            "fullName" : "CyC2018/CS-Notes"
        ]
        
        if let dict = myDict as? [AnyHashable : Any], let mock = try? RepositoriesModel(dictionary: dict) {
            return [mock]
        }
        
        return []
    }
    
}
