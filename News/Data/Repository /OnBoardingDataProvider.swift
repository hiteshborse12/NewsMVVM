//
//  OnBoardingDataProvider.swift
//  News
//
//  Created by Neosoft on 22/08/22.
//

import Foundation
// MARK: - OnBoardingDataProvider which conform OnBoardingUseCase Protocol
class OnBoardingDataProvider: OnBoardingUseCase {

    init() {
    }
   
    func execute(countryISO: String,category:String,country:String)-> UserSelectedCategoryCountry {
        let userSelectedCategoryCountry = UserSelectedCategoryCountry(countryISO: countryISO,
                                        category: category,
                                        country: country)
        return userSelectedCategoryCountry
    }
}
