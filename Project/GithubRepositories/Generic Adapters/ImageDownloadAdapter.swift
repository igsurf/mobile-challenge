import CoreArchitecture
import CoreInterfaces
import Foundation
import UIKit

final class ImageDownloadAdapter {
    let service: RawDataDownloadeService

    init(service: RawDataDownloadeService = RawDataDownloadServiceProvider.default()) {
        self.service = service
    }

    func getImage(from url: String?, completion: @escaping (UIImage?, Error?) -> Void) {
        guard let url = url, url.isEmpty == false else {
            completion(nil, nil)
            return
        }

        service.getData(
            from: url,
            onCompletion: { data in
                guard let image = UIImage(data: data) else { return }
                completion(image, nil)
            },

            onError: { error in
                completion(nil, error)
            }
        )
    }
}
