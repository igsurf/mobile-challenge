//
//  PullRequestsViewModel.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 12/04/21.
//

import Foundation

class PullRequestsViewModel {

    // MARK: - Private Properties

    private let model: [PullRequest]
    private enum StateType: String {
        case closed
        case open
    }

    // MARK: - Life Cycle

    init(model: [PullRequest]) {
        self.model = model
    }

    // MARK: - Public Methods

    var pullRequestsCount: Int {
        model.count
    }

    func getPullRequest(position: Int) -> PullRequest {
        model[position]
    }

    func getPullRequestURL(position: Int) -> URL? {
        let pullRequest = getPullRequest(position: position)
        return URL(string: pullRequest.htmlURL)
    }

    var openClosedTitle: NSAttributedString {
        let rawString = String(format: LocalizedStrings.openClosedTitle.localized(), openCount, closedCount)
        let textToChangeColor = String(format: LocalizedStrings.openPullRequest.localized(), openCount)
        return rawString.changeColor(in: [textToChangeColor], color: #colorLiteral(red: 0.8736335635, green: 0.5399934649, blue: 0, alpha: 1))
    }

    // MARK: - Private Methods

    private var openCount: Int {
        var count = 0
        for item in model {
            if item.state == StateType.open.rawValue {
                count += 1
            }
        }
        return count
    }

    private var closedCount: Int {
        var count = 0
        for item in model {
            if item.state == StateType.closed.rawValue {
                count += 1
            }
        }
        return count
    }
}
