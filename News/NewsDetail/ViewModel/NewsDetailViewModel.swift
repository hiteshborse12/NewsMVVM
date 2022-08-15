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
    func getNewsUrl()->URL?
}

class NewsDetailViewModel: NewsDetailViewModelProtocol {
    private var selectedNews: News
    // MARK: -Init ViewModel with news param
    init(news:News) {
        selectedNews = news
    }
}

// MARK: - return data for view
extension NewsDetailViewModel{
    func getNews() -> News {
       return selectedNews
    }
    func getTitle() -> String {
        StringConstants.news
    }
    func getNewsUrl() -> URL? {
        guard let stringURL = selectedNews.url?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
              let url = URL(string: stringURL) else {
                  return nil
              }
        return url
    }
}
