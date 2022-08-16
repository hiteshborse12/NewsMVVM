//
//  UIImageView+Ext.swift
//  News
//
//  Created by Neosoft on 11/08/22.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func setImageWith(url: String, placeHolder: UIImage = #imageLiteral(resourceName: "Placeholder")) {
        self.sd_setImage(with: URL(string: url), placeholderImage: placeHolder, options: [], context: [:])
    }

}
