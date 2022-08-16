//
//  NewsTests.swift
//  NewsTests
//
//  Created by Neosoft on 11/08/22.
//

import XCTest
import Nimble
@testable import News

class NewsTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
// MARK: OnBoardingViewModel
extension NewsTests{
    func testOnBoardingViewModelWithSelctedItem() throws{
        let onBoardingViewModel = OnBoardingViewModel()
        onBoardingViewModel.selectedCountryIndex = 1
        onBoardingViewModel.selectedCategoryIndex = 1
        onBoardingViewModel.startWithSelectedCategoryCountry()
        
        expect(onBoardingViewModel.userSelectedCategoryCountry?.country).notTo(beNil(), description: "Selected country is nil")
        expect(onBoardingViewModel.userSelectedCategoryCountry?.category).notTo(beNil(), description: "Selected category is nil")
    }
    
    func testOnBoardingViewModelWithNoSelctedItem() throws{
        let onBoardingViewModel = OnBoardingViewModel()
        onBoardingViewModel.startWithSelectedCategoryCountry()
        
        expect(onBoardingViewModel.userSelectedCategoryCountry?.country).to(beNil(), description: "Selected country is not nil")
        expect(onBoardingViewModel.userSelectedCategoryCountry?.category).to(beNil(), description: "Selected category is not nil")
    }
}

// MARK: NewsListViewModel
extension NewsTests{
    func testNewsListViewModelWithNews() throws{
        let userSelectedCategoryCountry = UserSelectedCategoryCountry(countryISO: NewsCountry.canada.isoCode, category: NewsCategory.business.rawValue, country: NewsCountry.canada.rawValue)
        let mockNewsListDataProvider = MockNewsListDataProvider(shouldReturnError: false)
        let newsListViewModel = NewsListViewModel(userSelectedCategoryCountry: userSelectedCategoryCountry, dataSource: mockNewsListDataProvider)
        
        newsListViewModel.fetchNews()
        expect(newsListViewModel.getNewsCount()) > 0
        newsListViewModel.loadMoreNews()
        expect(newsListViewModel.getNewsCount()) > 0
        expect(newsListViewModel.getNews(at:1000)).to(beNil())
    }
    func testNewsListViewModelForSearch() throws{
        let userSelectedCategoryCountry = UserSelectedCategoryCountry(countryISO: NewsCountry.canada.isoCode, category: NewsCategory.business.rawValue, country: NewsCountry.canada.rawValue)
        let mockNewsListDataProvider = MockNewsListDataProviderForSearch()
        let newsListViewModel = NewsListViewModel(userSelectedCategoryCountry: userSelectedCategoryCountry, dataSource: mockNewsListDataProvider)
        
        newsListViewModel.searchForArticle(by:"demo")
        
        // ToEventually Wait until currentState change to searching
        expect(newsListViewModel.currentSearchingState).toEventually(equal(.searching(text: "demo")))
        expect(newsListViewModel.getNewsCount()) == 0
    }
    func testNewsListViewModelForEmptyArray() throws{
        let userSelectedCategoryCountry = UserSelectedCategoryCountry(countryISO: NewsCountry.canada.isoCode, category: NewsCategory.business.rawValue, country: NewsCountry.canada.rawValue)
        let mockNewsListDataProvider = MockNewsListDataProviderForEmptyArray()
        let newsListViewModel = NewsListViewModel(userSelectedCategoryCountry: userSelectedCategoryCountry, dataSource: mockNewsListDataProvider)
        newsListViewModel.fetchNews()
        expect(newsListViewModel.getNewsCount()) == 0
    }
    func testNewsListViewModelWithError() throws{
        let userSelectedCategoryCountry = UserSelectedCategoryCountry(countryISO: NewsCountry.canada.isoCode, category: NewsCategory.business.rawValue, country: NewsCountry.canada.rawValue)
        let mockNewsListDataProvider = MockNewsListDataProvider(shouldReturnError: true)
        let onBoardingViewModel = NewsListViewModel(userSelectedCategoryCountry: userSelectedCategoryCountry, dataSource: mockNewsListDataProvider)
        
        onBoardingViewModel.fetchNews()
        expect(onBoardingViewModel.getNewsCount()) == 0
    }
}
// MARK: NewsListDataProvider
extension NewsTests{
    func testNewsListDataProviderWithRealApi() throws{
        let userSelectedCategoryCountry = UserSelectedCategoryCountry(countryISO: NewsCountry.canada.isoCode, category: NewsCategory.business.rawValue, country: NewsCountry.canada.rawValue)
        let newsListDataProvider = NewsListDataProvider()
       
        let requestParameters = NewsListParameters(country: userSelectedCategoryCountry.countryISO,
                                                   category: userSelectedCategoryCountry.category,
                                                   page: 1,
                                                   query: "")
        
        waitUntil(timeout: .seconds(5)) { done in
            newsListDataProvider.loadData(requestParameters: requestParameters) { newsResult in
                switch newsResult{
                case .success(let value):
                    expect(value.articles?.count) > 0
                case .failure(let error):
                    expect(error).notTo(beNil())
                }
                 done()
            }
        }
    }
    func testNewsListDataProviderWithError() throws{
        let userSelectedCategoryCountry = UserSelectedCategoryCountry(countryISO: NewsCountry.canada.isoCode, category: NewsCategory.business.rawValue, country: NewsCountry.canada.rawValue)
        let newsListDataProvider = NewsListDataProvider()
       
        var requestParameters = NewsListParameters(country: userSelectedCategoryCountry.countryISO,
                                                   category: userSelectedCategoryCountry.category,
                                                   page: 1,
                                                   query: "")
        // Invalid apiKey
        requestParameters.apiKey = "empty"
        waitUntil(timeout: .seconds(5)) { done in
            newsListDataProvider.loadData(requestParameters: requestParameters) { newsResult in
                switch newsResult{
                case .success(let value):
                    expect(value.articles?.count) > 0
                case .failure(let error):
                    expect(error).notTo(beNil())
                }
                 done()
            }
        }
    }
}
// MARK: NewsDetailViewModel
extension NewsTests{
    func testNewsDetailViewModelWithUrl() throws{
        let newsDetailViewModel = NewsDetailViewModel(news: News(source: Source(id: "11", name: "nameABC"), author: "authorABC", title: "titleABC", articleDescription: "articleDescriptionABC", url: "https://www.cnbc.com/2022/08/15/premium-products-take-priority-as-companies-battle-cost-of-living.html", urlToImage: "https://image.cnbcfm.com/api/v1/image/107103080-1660299891076-GettyImages-1406297560.jpg?v=1660300047&w=1920&h=1080", publishedAt: "2022-08-15T05:52:56Z", content: "contentABC"))
        
        expect(newsDetailViewModel.getNews).notTo(beNil(), description: "Selected country is nil")
        expect(newsDetailViewModel.getTitle).notTo(beNil(), description: "News title is nil")
        expect(newsDetailViewModel.getNewsUrl).notTo(beNil(), description: "News URL is nil")
    }
    func testNewsDetailViewModelWithEmptyUrl() throws{
        let newsDetailViewModel = NewsDetailViewModel(news: News(source: Source(id: "11", name: "nameABC"), author: "authorABC", title: "titleABC", articleDescription: "articleDescriptionABC", url: nil, urlToImage: "https://image.cnbcfm.com/api/v1/image/107103080-1660299891076-GettyImages-1406297560.jpg?v=1660300047&w=1920&h=1080", publishedAt: "2022-08-15T05:52:56Z", content: "contentABC"))
        
        expect(newsDetailViewModel.getNews).notTo(beNil(), description: "Selected country is nil")
        expect(newsDetailViewModel.getTitle).notTo(beNil(), description: "News title is nil")
        expect(newsDetailViewModel.getNewsUrl).to(beNil(), description: "News URL is nil")
    }
}
