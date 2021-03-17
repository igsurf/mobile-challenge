import Foundation

public extension Repository {
    struct Owner: Decodable, Equatable {
        public let login: String
        public let avatarUrl: String?
    }
}

#if DEBUG
public extension Repository.Owner {
    static func fixture(
        login: String = "12345",
        avatarUrl: String? = "Salad"
    ) -> Self {
        Self(
            login: login,
            avatarUrl: avatarUrl
        )
    }
}
#endif
