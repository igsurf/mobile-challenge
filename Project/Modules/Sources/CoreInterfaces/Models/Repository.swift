import Foundation

public struct Repository: Decodable, Equatable {
    public let id: Int
    public let name: String
    public let description: String?
    public let forksCount: Int?
    public let stargazersCount: Int?
    public let owner: Owner?
}

#if DEBUG
public extension Repository {
    static func fixture(
        id: Int = 12345,
        name: String = "Salad",
        description: String? = "Description",
        forksCount: Int? = 10,
        stargazersCount: Int? = 10,
        owner: Owner? = .fixture()
    ) -> Self {
        .init(
            id: id,
            name: name,
            description: description,
            forksCount: forksCount,
            stargazersCount: stargazersCount,
            owner: owner
        )
    }
}
#endif
