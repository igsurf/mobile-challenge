import Foundation

public struct User: Decodable, Equatable {
    public let login: String
    public let avatarUrl: String?
}

#if DEBUG
public extension User {
    static func fixture(
        login: String = "12345",
        avatarUrl: String? = "Salad"
    ) -> Self {
        .init(
            login: login,
            avatarUrl: avatarUrl
        )
    }
}
#endif
