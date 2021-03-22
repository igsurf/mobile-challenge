//
//  RepositoryViewCellController.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 13/03/21.
//

import Foundation

protocol RepositoryCellDelegate {
    func setTitle(title: String)
    func setDescription(description: String)
    func setForksView(forksCount: Int)
    func setStarView(starCount: Int)
    func setUser(user: UserViewModel)
}

public class RepositoryViewCellController {
    
    var delegate: RepositoryCellDelegate?
    var repository: RepositoryView?
    
    private var title: String {
        return self.repository?.name ?? ""
    }
    
    private var description: String {
        return self.repository?.descript ?? ""
    }
    
    private var forksCount: Int {
        return self.repository?.forksCount ?? 0
    }
    
    private var starCount: Int {
        return self.repository?.stargazersCount ?? 0
    }
    
    private var user: UserViewModel {
        var user = UserViewModel()
        user.avatar = self.repository?.ownerAvatar ?? ""
        user.login = self.repository?.ownerLogin ?? ""
        user.type = self.repository?.ownerUserType ?? ""
        return user
    }
    
    init(delegate: RepositoryCellDelegate) {
        self.delegate = delegate
    }
    
    func setup(repository: RepositoryView) {
        self.repository = repository
    }
    
    func setData() {
        self.delegate?.setTitle(title: self.title)
        self.delegate?.setDescription(description: self.description)
        self.delegate?.setForksView(forksCount: self.forksCount)
        self.delegate?.setStarView(starCount: self.starCount)
        self.delegate?.setUser(user: self.user)
    }
}
