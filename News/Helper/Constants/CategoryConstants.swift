//
//  CategoryConstants.swift
//  News
//
//  Created by Neosoft on 22/08/22.
//

import Foundation

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
