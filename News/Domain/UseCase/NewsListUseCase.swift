//
//  NewsListUseCase.swift
//  News
//
//  Created by Neosoft on 22/08/22.
//

import Foundation
import PromiseKit
// MARK: - Use case for news List
protocol NewsListUseCase {
    /**
     execute: Fetch News list
     - Parameter requestParameters: NewsListParameters
     - Returns: If Promise fulfill then T else erro
     */
    func execute(requestParameters: NewsListParameters)->Promise<NewsResponse>
}
