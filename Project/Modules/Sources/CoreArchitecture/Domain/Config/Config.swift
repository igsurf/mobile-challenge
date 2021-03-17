import Foundation

enum Config {
    static let baseURL = "https://api.github.com"
    static let requestTimeout = TimeInterval(30)

    static let defaultHeaders = ["Accept": "application/vnd.github.v3+json"]
}

