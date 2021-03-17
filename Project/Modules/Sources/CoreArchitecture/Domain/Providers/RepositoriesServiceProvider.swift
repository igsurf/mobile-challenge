import CoreInterfaces

public enum RepositoriesServiceProvider {
    public static func `default`() -> RepositoriesService {
        return RepositoriesServiceWorker()
    }
}
