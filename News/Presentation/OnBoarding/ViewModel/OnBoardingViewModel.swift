//
//  OnBoardingViewModel.swift
//  News
//
//  Created by Neosoft on 11/08/22.
//

import Foundation
import UIKit

protocol InputOnBoardingViewModelProtocol {
    func startWithSelectedCategoryCountry()
    var selectedCategoryIndex: Int? { get set}
    var selectedCountryIndex: Int? { get set}
}
protocol OuputOnBoardingViewModelProtocol {
    func getCategories() -> [String]
    func getCountries() -> [String]
    var userSelectedCategoryCountry: UserSelectedCategoryCountry? { get }
    var getOnBoardingState: ((OnBoardingViewState) -> Void) { get set}
}

// MARK: - Abstraction for OnBoardingViewModel
protocol OnBoardingViewModelProtocol:InputOnBoardingViewModelProtocol,OuputOnBoardingViewModelProtocol{
}
///The view model responsible for OnBoarding view controller
class OnBoardingViewModel: OnBoardingViewModelProtocol {
    private let useCase: OnBoardingUseCase
    var getOnBoardingState: ((OnBoardingViewState) -> Void) = {_ in}
    private var categories = NewsCategory.allCases
    private var countries = NewsCountry.allCases
    private(set) var userSelectedCategoryCountry: UserSelectedCategoryCountry?
    var selectedCategoryIndex: Int?
    var selectedCountryIndex: Int?
    /**
     Init OnBoardingViewModel
     - Parameter useCaseProvider: NewsListDataOnBoardingDataProviderProvider
     */
    init(useCaseProvider: OnBoardingUseCase) {
        self.useCase = useCaseProvider
    }
    // MARK: - start with selected category and country
    func startWithSelectedCategoryCountry() {
            guard let selectedCountryIndex = selectedCountryIndex,
                  let selectedCategoryIndex = selectedCategoryIndex else { getOnBoardingState(.error(ErrorHandler.selectFields))
                      return}
        self.userSelectedCategoryCountry = useCase.execute(countryISO: countries[selectedCountryIndex].isoCode, category: categories[selectedCategoryIndex].rawValue, country: countries[selectedCountryIndex].rawValue)
        getOnBoardingState(.start)
    }
}
// MARK: - return data for view
extension OnBoardingViewModel{
    func getCategories() -> [String] {
        categories.map { $0.rawValue.capitalized }
    }
    func getCountries() -> [String] {
        countries.map { $0.rawValue }
    }
}
// MARK: - OnBoardingView State
enum OnBoardingViewState {
    case error(Error)
    case start
}
