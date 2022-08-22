//
//  NewsListDataProviderTests.swift
//  NewsTests
//
//  Created by Neosoft on 22/08/22.
//

import XCTest
import Nimble
@testable import News

// MARK: Test NewsListDataProvider
class NewsListDataProviderTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testNewsListDataProviderWithRealApi() throws{
        let userSelectedCategoryCountry = UserSelectedCategoryCountry(countryISO: NewsCountry.canada.isoCode, category: NewsCategory.business.rawValue, country: NewsCountry.canada.rawValue)
        let newsListDataProvider = NewsListDataProvider()
       
        let requestParameters = NewsListParameters(country: userSelectedCategoryCountry.countryISO,
                                                   category: userSelectedCategoryCountry.category,
                                                   page: 1,
                                                   query: "")
        
        waitUntil(timeout: .seconds(5)) { done in
            
            newsListDataProvider.execute(requestParameters: requestParameters)
                .done { value in
                    expect(value.articles?.count) > 0
                    done()
                }
                .catch { error in
                    expect(error).notTo(beNil())
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
            newsListDataProvider.execute(requestParameters: requestParameters).done({ value in
                expect(value.articles?.count) > 0
                done()
            }).catch({ error in
                expect(error).notTo(beNil())
                done()
            })
        }
    }
}
