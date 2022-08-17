//
//  MockNewsListDataProvider.swift
//  News
//
//  Created by Neosoft on 15/08/22.
//

import Foundation
import PromiseKit
/**
 MockNewsListDataProvider: Mock news JSON response
 */
struct MockNewsListDataProvider: NewsListDataServiceprotocol {
    var shouldReturnError: Bool
    var error: Error = ErrorHandler.generalError
    func loadData(requestParameters: NewsListParameters) -> Promise<NewsResponse> {
        return Promise{seal in
            if shouldReturnError {
                seal.reject(error)
                return
            }
            var jSONObject = MockNewsJson.mockJSONResponsePage1
            let data = try! JSONSerialization.data(withJSONObject: jSONObject, options: .prettyPrinted)
            let decodedObject = try! JSONDecoder().decode(NewsResponse.self, from: data)
            seal.fulfill(decodedObject)
        }
    }
}
/**
 MockNewsListDataProviderForSearch: Empty mock JSON response for search
 */
struct MockNewsListDataProviderForSearch: NewsListDataServiceprotocol {
    func loadData(requestParameters: NewsListParameters) -> Promise<NewsResponse> {
        return Promise {seal in
            let data = try! JSONSerialization.data(withJSONObject: MockNewsJson.mockEmptyJSONResponse, options: .prettyPrinted)
            let decodedObject = try! JSONDecoder().decode(NewsResponse.self, from: data)
            seal.fulfill(decodedObject)
            
        }
    }
}
/**
 MockNewsListDataProviderForEmptyArray: Empty mock JSON response
 */
struct MockNewsListDataProviderForEmptyArray: NewsListDataServiceprotocol {
    func loadData(requestParameters: NewsListParameters) -> Promise<NewsResponse> {
        return Promise{ seal in
            let data = try! JSONSerialization.data(withJSONObject: MockNewsJson.mockEmptyJSONResponse, options: .prettyPrinted)
            let decodedObject = try! JSONDecoder().decode(NewsResponse.self, from: data)
            seal.fulfill(decodedObject)
        }
    }
}
