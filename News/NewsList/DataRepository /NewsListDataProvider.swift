//
//  NewsListDataSource.swift
//  News
//
//  Created by Neosoft on 11/08/22.
//

import Foundation

typealias NewsResult = Result<NewsResponse, Error>
typealias NewsBlock = (NewsResult) -> Void

protocol NewsListDataServiceprotocol {
    func loadData(requestParameters: NewsListParameters, completion: NewsBlock?)
}

class NewsListDataProvider: NewsListDataServiceprotocol {
    
    private var apiHandler: NetworkManagerProtocol
    
    init(apiHandler: NetworkManagerProtocol = NetworkManager.shared) {
        self.apiHandler = apiHandler
    }
    
    func loadData(requestParameters: NewsListParameters, completion: (NewsBlock?)) {
        let request = NewsListNetworking.fetchArticles(requestParameters)
        apiHandler.fetchData(request: request, mappingClass: NewsResponse.self) {[weak self] response in
            guard let self = self else { return }
            self.handleResponse(result: response, completion: completion)
        }
    }
    
    private func handleResponse(result: NewsResult, completion: NewsBlock?) {
        switch result {
        case .success(let value):
            completion?(.success(value))
        case .failure(let error):
            debugPrint(error.localizedDescription)
            completion?(.failure(error))
        }
    }
}
