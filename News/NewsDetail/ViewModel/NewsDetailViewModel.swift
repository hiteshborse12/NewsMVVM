//
//  NewsDetailViewModel.swift
//  News
//
//  Created by Neosoft on 12/08/22.
//

import Foundation

// MARK: - Abstraction for NewsDetailViewModel
protocol NewsDetailViewModelProtocol{
    func getNews()->News
    func getTitle()->String
}

class NewsDetailViewModel: NewsDetailViewModelProtocol {
    private var selectedNews: News
    init(news:News) {
        selectedNews = news
    }
    func getNews() -> News {
       return selectedNews
    }
    func getTitle() -> String {
        selectedNews.title?.capitalized ?? StringConstants.news
    }
}
