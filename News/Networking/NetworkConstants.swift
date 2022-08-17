//
//  NetworkConstants.swift
//  News
//
//  Created by Neosoft on 11/08/22.
//

import Foundation

// Sample apiKeys
//bff9ffaa7ddf4de38b14909e62e49061
//cc15cd9e16604a70888d3baef0c9f083
//5a930c8356d14db2bd475d72f7be713c
//0284b9b5ed9549b5a331a40c81c63d3a
enum NetworkConstants {
    private static var appEnvironment: Environment = .staging
    static let apiKey = "0284b9b5ed9549b5a331a40c81c63d3a"
    static let baseURL = appEnvironment.baseURL
    static let topHeadlines = "top-headlines"
}
enum Environment {
    case staging
    case production
    var baseURL: String {
        switch self {
        case .staging:
            return "https://newsapi.org/v2/"
        case .production:
            //for now we don't have any live url
            return "https://newsapi.org/v2/"
        }
    }
}
