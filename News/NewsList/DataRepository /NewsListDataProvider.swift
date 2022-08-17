//
//  NewsListDataSource.swift
//  News
//
//  Created by Neosoft on 11/08/22.
//

import Foundation
import PromiseKit

// MARK: - Abstraction for NewsListDataProvider
protocol NewsListDataServiceprotocol {
    /**
     loadData: Fetch News list
     - Parameter requestParameters: NewsListParameters
     - Returns: If Promise fulfill then T else erro
     */
    func loadData(requestParameters: NewsListParameters)->Promise<NewsResponse>
}

class NewsListDataProvider: NewsListDataServiceprotocol {
    
    private var apiHandler: NetworkManagerProtocol
    /**
     Init NewsListDataProvider
     - Parameter apiHandler: NetworkManager(Default)
     */

    init(apiHandler: NetworkManagerProtocol = NetworkManager.shared) {
        self.apiHandler = apiHandler
    }
   
    func loadData(requestParameters: NewsListParameters)-> Promise<NewsResponse> {
        return Promise{seal in
            let request = NewsListNetworking.fetchArticles(requestParameters)
            apiHandler.fetchData(request: request, mappingClass: NewsResponse.self)
                .done { newsResponse in
                    seal.fulfill(newsResponse)}
                .catch { error in
                    seal.reject(error)}
        }
    }
}
