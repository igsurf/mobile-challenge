//
//  DataUnwraper.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 10/04/21.
//

import Foundation

class DataUnwraper {
    static func unwrapModel<T: Decodable>(of type: T.Type, data: Data, success: @escaping(T) -> Void, failure: @escaping(Error) -> Void) {
        do {
            let model: T = try JSONDecoder().decode(T.self, from: data)
            success(model)
        } catch {
            failure(error)
        }
    }
}
