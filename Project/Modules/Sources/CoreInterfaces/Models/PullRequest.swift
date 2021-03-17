import Foundation

public struct PullRequest: Decodable, Equatable {
    let title: String
    let createdAt: String
    let body: String
    let htmlUrl: String
    let user: User
}

#if DEBUG
public extension PullRequest {
    static func fixture(
        title: String = "Dummy PR",
        createdAt: String = "2012-10-09T23:39:01Z",
        body: String = "Description of PR",
        htmlUrl: String = "https://nothing.no",
        user: User = .fixture()
    ) -> Self {
        .init(
            title: title,
            createdAt: createdAt,
            body: body,
            htmlUrl: htmlUrl,
            user: user
        )
    }
}
#endif
