//
//  NewsListViewModel.swift
//  News
//
//  Created by Neosoft on 11/08/22.
//

import Foundation

protocol NewsListViewModelProtocol {
    func fetchNews()
    func getNewsCount() -> Int
    func getNews(at index: Int) -> News?
    func loadMoreNews()
    func searchForArticle(by text: String)
    func getTitle() -> String
    var getLoadingState: ((State) -> Void) { get set}
}

class NewsListViewModel: NewsListViewModelProtocol {
    private let userSelectedCategoryCountry: UserSelectedCategoryCountry
    private let dataSource: NewsListDataServiceprotocol
    private var newsArray = [News]()
    private var searchedArticles = [News]()
    private var pageNumber: Int = 1
    private var hasMoreItems: Bool = true
    private var pendingRequestWorkItem: DispatchWorkItem?
    private(set) var currentState: NewsListState = .notSearching
    private weak var timer: Timer?
    var getLoadingState: ((State) -> Void) = {_ in }
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
        switch currentState {
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
            currentState = .notSearching
            fetchNews()
        } else {
            pageNumber = 1
            let requestWorkItem = DispatchWorkItem { [weak self] in
                guard let self = self else { return }
                self.currentState = .searching(text: text)
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
        let count = currentState == .notSearching ? newsArray.count : searchedArticles.count
        if count == 0 {
            self.getLoadingState(.empty)
        }
        return count
    }
    
    func getNews(at index: Int) -> News? {
        if currentState == .notSearching{ if newsArray.indices.contains(index){return newsArray[index]} else{return nil}}
        else { if searchedArticles.indices.contains(index){return searchedArticles[index]} else{return nil}}}
    func getTitle() -> String {
        userSelectedCategoryCountry.category.capitalized}
}
// MARK: - loadData from data source
extension NewsListViewModel {
    func loadData(searchText: String? = nil, isLoadMore: Bool) {
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
        dataSource.loadData(requestParameters: requestParameters) {[weak self] result in
            guard let self = self else { return }
            self.handleDataLoading(result: result)
        }
    }
    
    private func handleDataLoading(result: NewsResult) {
        switch result {
        case .success(let value):
            setData(items: value.articles ?? [])
            checkHasMoreItems(totalResultCount: value.totalResults ?? 0,
                              isNewArrayNotEmpty: !(value.articles?.isEmpty ?? false))
        case .failure(let error):
            self.getLoadingState(.error(error))
        }
    }
    
    func setData(items: [News]) {
        switch currentState {
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
