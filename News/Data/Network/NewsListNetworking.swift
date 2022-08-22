//
//  NewsListNetworking.swift
//  News
//
//  Created by Neosoft on 11/08/22.
//

import Foundation
import Alamofire

enum NewsListNetworking {
    case fetchArticles(NewsListParameters)
}

extension NewsListNetworking: ApiRequest {
    var baseURL: String {
        return NetworkConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchArticles:
            return NetworkConstants.topHeadlines
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchArticles:
            return .get
        }
    }
    
    var parameters: [String : Any] {
        switch self {
            
        case .fetchArticles(let params):
            return params.toJSON()
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .fetchArticles(_):
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .fetchArticles:
            return URLEncoding.default
        }
    }
}
