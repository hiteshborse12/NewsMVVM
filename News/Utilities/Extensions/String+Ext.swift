//
//  String+Ext.swift
//  News
//
//  Created by Neosoft on 11/08/22.
//

import Foundation

extension String {
    func UTCToLocal() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "MMM d, h:mm a"
        guard let date = dt else {
            return nil
        }
        return dateFormatter.string(from: date)
    }
}
