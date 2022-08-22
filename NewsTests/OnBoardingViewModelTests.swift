//
//  OnBoardingViewModelTests.swift
//  NewsTests
//
//  Created by Neosoft on 22/08/22.
//

import XCTest
import Nimble
@testable import News

// MARK: Test OnBoardingViewModel
class OnBoardingViewModelTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testOnBoardingViewModelWithSelctedItem() throws{
        let onBoardingViewModel = OnBoardingViewModel(useCaseProvider: OnBoardingDataProvider())
        onBoardingViewModel.selectedCountryIndex = 1
        onBoardingViewModel.selectedCategoryIndex = 1
        onBoardingViewModel.startWithSelectedCategoryCountry()
        
        expect(onBoardingViewModel.userSelectedCategoryCountry?.country).notTo(beNil(), description: "Selected country is nil")
        expect(onBoardingViewModel.userSelectedCategoryCountry?.category).notTo(beNil(), description: "Selected category is nil")
    }
    
    func testOnBoardingViewModelWithNoSelctedItem() throws{
        let onBoardingViewModel = OnBoardingViewModel(useCaseProvider: OnBoardingDataProvider())
        onBoardingViewModel.startWithSelectedCategoryCountry()
        
        expect(onBoardingViewModel.userSelectedCategoryCountry?.country).to(beNil(), description: "Selected country is not nil")
        expect(onBoardingViewModel.userSelectedCategoryCountry?.category).to(beNil(), description: "Selected category is not nil")
    }
}
