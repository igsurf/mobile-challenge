import CoreInterfaces

public enum RawDataDownloadServiceProvider {
    public static func `default`() -> RawDataDownloadeService {
        return RawDataDownloaderWorker()
    }
}
