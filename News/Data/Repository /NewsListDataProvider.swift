//
//  NewsListDataSource.swift
//  News
//
//  Created by Neosoft on 11/08/22.
//

import Foundation
import PromiseKit
// MARK: - NewsListDataProvider which conform NewsListUseCase Protocol
class NewsListDataProvider: NewsListUseCase {
    
    private var apiHandler: NetworkManagerProtocol
    /**
     Init NewsListDataProvider
     - Parameter apiHandler: NetworkManager(Default)
     */

    init(apiHandler: NetworkManagerProtocol = NetworkManager.shared) {
        self.apiHandler = apiHandler
    }
   
    func execute(requestParameters: NewsListParameters)-> Promise<NewsResponse> {
        return Promise{seal in
            let request = NewsListNetworking.fetchArticles(requestParameters)
            apiHandler.fetchData(request: request)
                .done { newsResponse in
                    seal.fulfill(newsResponse)}
                .catch { error in
                    seal.reject(error)}
        }
    }
}
