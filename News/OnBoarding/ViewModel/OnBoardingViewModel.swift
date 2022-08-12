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
    var moveToNewsListVc: (() -> Void) { get set}
    var userSelectedCategoryCountry: UserSelectedCategoryCountry? { get }
}

// MARK: - Abstraction for OnBoardingViewModel
protocol OnBoardingViewModelProtocol:InputOnBoardingViewModelProtocol,OuputOnBoardingViewModelProtocol{
}

// MARK: - OnBoardingViewModel confirm OnBoardingViewModelProtocol
class OnBoardingViewModel: OnBoardingViewModelProtocol {
    var moveToNewsListVc: (() -> Void) = { }
    private var categories = NewsCategory.allCases
    private var countries = NewsCountry.allCases
    private(set) var userSelectedCategoryCountry: UserSelectedCategoryCountry?
    var selectedCategoryIndex: Int?
    var selectedCountryIndex: Int?
    
    func startWithSelectedCategoryCountry() {
            guard let selectedCountryIndex = selectedCountryIndex,
                  let selectedCategoryIndex = selectedCategoryIndex else {return}
        let userSelectedCategoryCountry = UserSelectedCategoryCountry(countryISO: countries[selectedCountryIndex].isoCode,
                                        category: categories[selectedCategoryIndex].rawValue,
                                        country: countries[selectedCountryIndex].rawValue)
        self.userSelectedCategoryCountry = userSelectedCategoryCountry
        self.moveToNewsListVc()
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
