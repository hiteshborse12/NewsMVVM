//
//  MockNewsListDataProvider.swift
//  News
//
//  Created by Neosoft on 15/08/22.
//

import Foundation
struct MockNewsListDataProvider: NewsListDataServiceprotocol {
    var shouldReturnError: Bool
    var error: Error = ErrorHandler.generalError
    
    func loadData(requestParameters: NewsListParameters, completion: (NewsBlock)?) {
        if shouldReturnError {
            completion?(.failure(error))
            return
        }
        let data = try! JSONSerialization.data(withJSONObject: MockNewsJson.mockJSONResponse, options: .prettyPrinted)
        let decodedObject = try! JSONDecoder().decode(NewsResponse.self, from: data)
        completion?(.success(decodedObject))
    }
}
struct MockNewsListDataProviderForSearch: NewsListDataServiceprotocol {
    func loadData(requestParameters: NewsListParameters, completion: (NewsBlock)?) {
        let data = try! JSONSerialization.data(withJSONObject: MockNewsJson.mockEmptyJSONResponse, options: .prettyPrinted)
        let decodedObject = try! JSONDecoder().decode(NewsResponse.self, from: data)
        completion?(.success(decodedObject))
    }
}
