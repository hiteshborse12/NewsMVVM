//
//  NewsListViewModelTests.swift
//  NewsTests
//
//  Created by Neosoft on 22/08/22.
//

import XCTest
import Nimble
@testable import News

// MARK: Test NewsListViewModelTests
class NewsListViewModelTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testNewsListViewModelWithNews() throws{
        let userSelectedCategoryCountry = UserSelectedCategoryCountry(countryISO: NewsCountry.canada.isoCode, category: NewsCategory.business.rawValue, country: NewsCountry.canada.rawValue)
        let mockNewsListDataProvider = MockNewsListDataProvider(shouldReturnError: false)
        let newsListViewModel = NewsListViewModel(userSelectedCategoryCountry: userSelectedCategoryCountry, useCaseProvider: mockNewsListDataProvider)
        
        newsListViewModel.fetchNews()
        expect(newsListViewModel.getNewsCount()).toEventually(equal(10))
        newsListViewModel.loadMoreNews()
        expect(newsListViewModel.getNewsCount()).toEventually(equal(20))
        expect(newsListViewModel.getNews(at:1000)).to(beNil())
    }
    func testNewsListViewModelForSearch() throws{
        let userSelectedCategoryCountry = UserSelectedCategoryCountry(countryISO: NewsCountry.canada.isoCode, category: NewsCategory.business.rawValue, country: NewsCountry.canada.rawValue)
        let mockNewsListDataProvider = MockNewsListDataProviderForSearch()
        let newsListViewModel = NewsListViewModel(userSelectedCategoryCountry: userSelectedCategoryCountry, useCaseProvider: mockNewsListDataProvider)
        
        newsListViewModel.searchForArticle(by:"demo")
        
        // ToEventually Wait until currentState change to searching
        expect(newsListViewModel.currentSearchingState).toEventually(equal(.searching(text: "demo")))
        expect(newsListViewModel.getNewsCount()) == 0
    }
    func testNewsListViewModelForEmptyArray() throws{
        let userSelectedCategoryCountry = UserSelectedCategoryCountry(countryISO: NewsCountry.canada.isoCode, category: NewsCategory.business.rawValue, country: NewsCountry.canada.rawValue)
        let mockNewsListDataProvider = MockNewsListDataProviderForEmptyArray()
        let newsListViewModel = NewsListViewModel(userSelectedCategoryCountry: userSelectedCategoryCountry, useCaseProvider: mockNewsListDataProvider)
        newsListViewModel.fetchNews()
        expect(newsListViewModel.getNewsCount()) == 0
    }
    func testNewsListViewModelWithError() throws{
        let userSelectedCategoryCountry = UserSelectedCategoryCountry(countryISO: NewsCountry.canada.isoCode, category: NewsCategory.business.rawValue, country: NewsCountry.canada.rawValue)
        let mockNewsListDataProvider = MockNewsListDataProvider(shouldReturnError: true)
        let onBoardingViewModel = NewsListViewModel(userSelectedCategoryCountry: userSelectedCategoryCountry, useCaseProvider: mockNewsListDataProvider)
        
        onBoardingViewModel.fetchNews()
        expect(onBoardingViewModel.getNewsCount()) == 0
    }
}
