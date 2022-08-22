//
//  NewsDetailViewModelTests.swift
//  NewsTests
//
//  Created by Neosoft on 22/08/22.
//

import XCTest
import Nimble
@testable import News

// MARK: Test NewsDetailViewModel
class NewsDetailViewModelTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
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
