//
//  NewsListViewModel.swift
//  News
//
//  Created by Neosoft on 11/08/22.
//

import Foundation
import PromiseKit

// MARK: - Abstraction for NewsListViewModel
protocol NewsListViewModelProtocol {
    func fetchNews()
    func getNewsCount() -> Int
    func getNews(at index: Int) -> News?
    func loadMoreNews()
    func searchForArticle(by text: String)
    func getTitle() -> String
    var getLoadingState: ((State) -> Void) { get set}
}
///The view model responsible for NewsList view controller
class NewsListViewModel: NewsListViewModelProtocol {
    private let userSelectedCategoryCountry: UserSelectedCategoryCountry
    private let dataSource: NewsListDataServiceprotocol
    private var newsArray = [News]()
    private var searchedArticles = [News]()
    private var pageNumber: Int = 1
    private var hasMoreItems: Bool = true
    private var pendingRequestWorkItem: DispatchWorkItem?
    private(set) var currentSearchingState: NewsListState = .notSearching
    var getLoadingState: ((State) -> Void) = {_ in }
    
    /**
     Init NewsListViewModel
     - Parameter userSelectedCategoryCountry: UserSelectedCategoryCountry.
     - Parameter dataSource: NewsListDataProvider
     */
    
    init(userSelectedCategoryCountry: UserSelectedCategoryCountry, dataSource: NewsListDataServiceprotocol) {
        self.userSelectedCategoryCountry = userSelectedCategoryCountry
        self.dataSource = dataSource
    }
    // MARK: - fetch fresh news
    func fetchNews() {
        newsArray = [News]()
        pageNumber = 1
        hasMoreItems = true
        loadData(isLoadMore: false)
    }
    
    func loadMoreNews() {
        switch currentSearchingState {
        case .searching(text: let text):
            loadData(searchText: text, isLoadMore: true)
        case .notSearching:
            loadData(isLoadMore: true)
        }
    }
    // MARK: - Search news by text
    func searchForArticle(by text: String) {
        hasMoreItems = true
        searchedArticles.removeAll()
        // cleard  pending search request
        pendingRequestWorkItem?.cancel()
        if text.isEmpty {
            currentSearchingState = .notSearching
            fetchNews()
        } else {
            pageNumber = 1
            let requestWorkItem = DispatchWorkItem { [weak self] in
                guard let self = self else { return }
                self.currentSearchingState = .searching(text: text)
                self.loadData(searchText: text, isLoadMore: false)
            }
            pendingRequestWorkItem = requestWorkItem
            
            //load data after delay
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250),
                                          execute: requestWorkItem)
        }
    }
    
}
// MARK: - return data for view
extension NewsListViewModel{
    func getNewsCount() -> Int {
        let count = currentSearchingState == .notSearching ? newsArray.count : searchedArticles.count
        if count == 0 {
            self.getLoadingState(.empty)
        }
        return count
    }
    
    func getNews(at index: Int) -> News? {
        if currentSearchingState == .notSearching{ if newsArray.indices.contains(index){return newsArray[index]} else{return nil}}
        else { if searchedArticles.indices.contains(index){return searchedArticles[index]} else{return nil}}}
    func getTitle() -> String {
        userSelectedCategoryCountry.category.capitalized}
}
// MARK: - loadData from data source
extension NewsListViewModel {
    private func loadData(searchText: String? = nil, isLoadMore: Bool) {
        guard hasMoreItems else { return }
        if isLoadMore {
            self.getLoadingState(.loadingMore)
        } else {
            self.getLoadingState(.loading)
        }
        let requestParameters = NewsListParameters(country: userSelectedCategoryCountry.countryISO,
                                                   category: userSelectedCategoryCountry.category,
                                                   page: pageNumber,
                                                   query: searchText)
        dataSource.loadData(requestParameters: requestParameters)
            .done { newsResponse in
                self.setData(items: newsResponse.articles ?? [])
                self.checkHasMoreItems(totalResultCount: newsResponse.totalResults ?? 0,
                                  isNewArrayNotEmpty: !(newsResponse.articles?.isEmpty ?? false))
            }
            .catch { error in
                self.getLoadingState(.error(error))
            }
    }
    
    func setData(items: [News]) {
        switch currentSearchingState {
        case .searching:
            self.searchedArticles.append(contentsOf: items)
            self.getLoadingState(.populated)
        case .notSearching:
            self.newsArray.append(contentsOf: items)
            self.getLoadingState(.populated)
        }
    }
    
    func checkHasMoreItems(totalResultCount: Int, isNewArrayNotEmpty: Bool) {
        if newsArray.count < totalResultCount && isNewArrayNotEmpty {
            pageNumber += 1
        } else {
            hasMoreItems = false
        }
    }
}
// MARK: - States
enum NewsListState: Equatable {
    case searching(text: String)
    case notSearching
}
enum State {
    case loading
    case loadingMore
    case error(Error)
    case empty
    case populated
}
