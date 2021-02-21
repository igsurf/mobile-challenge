//
//  Strings.swift
//  mobile-challenger
//
//  Created by Leonardo Sugano on 19/02/21.
//

import Foundation

extension String {
    
    //MARK: - Lets
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func transformDateToFormat(format: String) -> String {
        let dateAPIFormatter = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = dateAPIFormatter
        
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = format
        
        if let date = date {
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        
        return String()
    }
}
