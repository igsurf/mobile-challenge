import Foundation

extension Fixture {
    struct PullRequestsList {
        static let data = PullRequestsList.json.data(using: .utf8) ?? Data(capacity: 0)
        static let json = #"""
            [
                {
                    "title": "First PR",
                    "html_url": "https://github.com/",
                    "body": "Just a First PR",
                    "created_at": "2011-01-26T00:00:00Z",
                    "user": {
                        "login": "user01",
                        "avatar_url": "https://github.com/images/user01.gif",
                    }
                },
                {
                    "title": "Second PR",
                    "html_url": "https://github.com/",
                    "body": "Just a Second PR",
                    "created_at": "2011-01-26T00:00:00Z",
                    "user": {
                        "login": "user02",
                        "avatar_url": "https://github.com/images/user02.gif",
                    }
                }
            ]
        """#
    }
}
