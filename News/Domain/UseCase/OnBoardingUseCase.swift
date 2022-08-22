//
//  OnBoardingUseCase.swift
//  News
//
//  Created by Neosoft on 22/08/22.
//

import Foundation
// MARK: - Use case for OnBoarding 
protocol OnBoardingUseCase {
    /**
     execute: get user selected category and  country
     - Parameter countryISO: countryISO string value
     - Parameter category:  category string value
     - Parameter country:  country string value
     - Returns:UserSelectedCategoryCountry
     */
    func execute(countryISO: String,category:String,country:String)-> UserSelectedCategoryCountry
}
