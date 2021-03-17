import Foundation

extension Fixture {
    struct RepositoriesList {
        static let data = RepositoriesList.json.data(using: .utf8) ?? Data(capacity: 0)
        static let json = #"""
            [
                {
                    "id": 1,
                    "name": "repo01",
                    "owner": {
                      "login": "login01",
                      "avatar_url": "url01",
                    },
                    "description": "first repo"
                },
                {
                    "id": 2,
                    "name": "repo02",
                    "owner": {
                      "login": "login02",
                      "avatar_url": "url02",
                    },
                    "description": "second repo"
                },
                {
                    "id": 3,
                    "name": "repo03",
                    "owner": {
                      "login": "login03",
                      "avatar_url": "url03",
                    },
                    "description": "third repo"
                }
            ]
        """#
    }
}
