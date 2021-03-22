//
//  Date+Extension.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 28/02/21.
//

import Foundation

extension Date {
    func toString(withFormat format: String = "dd/MM/yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)

        return str
    }
}
