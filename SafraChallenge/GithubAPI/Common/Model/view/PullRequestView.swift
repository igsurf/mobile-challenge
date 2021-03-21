//
//  PullRequestView.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 11/03/21.
//

import Foundation

public struct PullRequestView {
    var id: Int = -1
    var body: String = ""
    var date: String = ""
    var ownerAvatar: String = ""
    var ownerName: String = ""
    var ownerType: String = ""
    var title: String = ""
    var url: String = ""
    var ofRepository: RepositoryView?
    var state: String = ""
}
