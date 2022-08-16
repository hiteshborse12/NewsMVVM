//
//  CustomButtonShadowView.swift
//  News
//
//  Created by Neosoft on 11/08/22.
//


import UIKit

class CustomButtonShadowView: UIView {
    
    @IBInspectable public var cornerRadius: CGFloat = 10
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    // MARK: - Setup View Method
    
    private func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2
        self.layer.masksToBounds = false
    }
}
