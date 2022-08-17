//
//  OnBoardingViewModel.swift
//  News
//
//  Created by Neosoft on 11/08/22.
//

import Foundation

protocol InputOnBoardingViewModelProtocol {
    func startWithSelectedCategoryCountry()
    var selectedCategoryIndex: Int? { get set}
    var selectedCountryIndex: Int? { get set}
}
protocol OuputOnBoardingViewModelProtocol {
    func getCategories() -> [String]
    func getCountries() -> [String]
    var userSelectedCategoryCountry: UserSelectedCategoryCountry? { get }
    var getOnBoardingState: ((OnBoardingState) -> Void) { get set}
}

// MARK: - Abstraction for OnBoardingViewModel
protocol OnBoardingViewModelProtocol:InputOnBoardingViewModelProtocol,OuputOnBoardingViewModelProtocol{
}
///The view model responsible for OnBoarding view controller
class OnBoardingViewModel: OnBoardingViewModelProtocol {
    var getOnBoardingState: ((OnBoardingState) -> Void) = {_ in}
    private var categories = NewsCategory.allCases
    private var countries = NewsCountry.allCases
    private(set) var userSelectedCategoryCountry: UserSelectedCategoryCountry?
    var selectedCategoryIndex: Int?
    var selectedCountryIndex: Int?
    
    func startWithSelectedCategoryCountry() {
            guard let selectedCountryIndex = selectedCountryIndex,
                  let selectedCategoryIndex = selectedCategoryIndex else { getOnBoardingState(.error(ErrorHandler.selectFields))
                      return}
        let userSelectedCategoryCountry = UserSelectedCategoryCountry(countryISO: countries[selectedCountryIndex].isoCode,
                                        category: categories[selectedCategoryIndex].rawValue,
                                        country: countries[selectedCountryIndex].rawValue)
        self.userSelectedCategoryCountry = userSelectedCategoryCountry
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
enum OnBoardingState {
    case error(Error)
    case start
}
