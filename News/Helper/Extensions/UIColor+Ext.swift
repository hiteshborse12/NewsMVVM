//
//  UIColor+Ext.swift
//  News
//
//  Created by Neosoft on 11/08/22.
//

import UIKit

enum Color: String {
    case appThemeBlue = "AppThemeBlue"
    case shadowColor = "AppThemeGray"
}

extension UIColor {
    static func color(for color: Color) -> UIColor {
        UIColor(named: color.rawValue) ?? UIColor()
    }
}
