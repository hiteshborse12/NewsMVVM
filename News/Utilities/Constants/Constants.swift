//
//  Constants.swift
//  News
//
//  Created by Neosoft on 12/08/22.
//

import Foundation

// MARK: - String Constants
enum StringConstants: Error {
    static let onboardingTitle = "Category & Country"
    static let backTitle = "Back"
    static let noNews = "Sorry, no news found"
}


// MARK: - ErrorHandler Constants
enum ErrorHandler: Error {
    case selectFields
    case invalidURL
    case generalError
    case custom(String)
    
    var message: String {
        switch self {
        case .selectFields:
            return "Please select all fields"
        case .invalidURL:
            return "URL is invalid"
        case .generalError:
            return "Something went wrong, please try again"
        case .custom(let message):
            return message
        }
    }
}

// MARK: - Category Constants
/*
 Available Categories
 business entertainment general health sciences ports technology
 */
enum NewsCategory: String, CaseIterable {
    case business
    case entertainment
    case general
    case health
    case sciences
    case ports
    case technology
}

// MARK: - Country Constants
enum NewsCountry: String, CaseIterable {
    case unitedStates = "The United States of America"
    case canada = "Canada"
    case switzerland = "Switzerland"
    case germany = "Germany"
    case emirates = "The United Arab Emirates"
    case argentina = "Argentina"
    case austria = "Austria"
    case australia = "Australia"
    case belgium = "Belgium"
    case bulgaria = "Bulgaria"
    case brazil = "Brazil"
    
    var isoCode: String {
        switch self {
        case .unitedStates:
            return "us"
        case .canada:
            return "ca"
        case .switzerland:
            return "ch"
        case .germany:
            return "de"
        case .emirates:
            return "ae"
        case .argentina:
            return "ar"
        case .austria:
            return "at"
        case .australia:
            return "au"
        case .belgium:
            return "be"
        case .bulgaria:
            return "bg"
        case .brazil:
            return "br"
        }
    }
}
