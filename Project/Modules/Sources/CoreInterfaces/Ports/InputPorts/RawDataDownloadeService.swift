import Foundation

public protocol RawDataDownloadeService {
    func getData(from url: String,
                 onCompletion: ((Data) -> Void)?,
                 onError: ((Error) -> Void)?)
}
