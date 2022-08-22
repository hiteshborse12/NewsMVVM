//
//  ErrorConstants.swift
//  News
//
//  Created by Neosoft on 22/08/22.
//

import Foundation

// MARK: - ErrorConstants
enum ErrorHandler: Error {
    case selectFields
    case generalError
    case custom(String)
    var message: String {
        switch self {
        case .selectFields:
            return "Please select all fields"
        case .generalError:
            return "Something went wrong, please try again"
        case .custom(let message):
            return message
        }
    }
}
