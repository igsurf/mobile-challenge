//
//  PullRequestViewCellController.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 15/03/21.
//

import Foundation

protocol PullRequestCellDelegate {
    func setTitle(title: String)
    func setDescription(description: String)
    func setDate(date: String)
    func setUser(user: UserViewModel)
}

class PullRequestViewCellController {
    var pullrequest: PullRequestView?
    var delegate: PullRequestCellDelegate?
    
    private var title: String {
        return self.pullrequest?.title ?? ""
    }
    
    private var description: String {
        return self.pullrequest?.body ?? ""
    }
    
    private var createdData: String {
        return self.pullrequest?.date ?? ""
    }
    
    private var user: UserViewModel {
        var user = UserViewModel()
        user.avatar = self.pullrequest?.ownerAvatar ?? ""
        user.login = self.pullrequest?.ownerName ?? ""
        user.type = self.pullrequest?.ownerType ?? ""
        return user
    }
    
    init(delegate: PullRequestCellDelegate) {
        self.delegate = delegate
    }
    
    func setup(pullrequest: PullRequestView) {
        self.pullrequest = pullrequest
    }
    
    func setData() {
        self.delegate?.setTitle(title: self.title)
        self.delegate?.setDescription(description: self.description)
        self.delegate?.setDate(date: self.createdData)
        self.delegate?.setUser(user: self.user)
    }
}
