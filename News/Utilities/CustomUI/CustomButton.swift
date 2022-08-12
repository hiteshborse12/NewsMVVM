//
//  CustomButton.swift
//  News
//
//  Created by Neosoft on 11/08/22.
//

import UIKit

class CustomButton: UIButton {
    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }
    // MARK: - Setup Button Methods
    private func setupButton() {
        self.layer.cornerRadius = 10
        self.backgroundColor = .color(for: .appThemeBlue)
        self.layer.shadowColor = UIColor.color(for: .shadowColor).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
        self.layer.masksToBounds = false
    }

}

