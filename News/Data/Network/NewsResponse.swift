//
//  NewsResponse.swift
//  News
//
//  Created by Neosoft on 22/08/22.
//

import Foundation
// MARK: - NewsResponse
struct NewsResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [News]?
}
