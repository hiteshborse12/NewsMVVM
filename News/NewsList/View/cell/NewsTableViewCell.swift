//
//  NewsTableViewCell.swift
//  News
//
//  Created by Neosoft on 11/08/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet private weak var newsImage: UIImageView!
    @IBOutlet private weak var newsTitle: UILabel!
    @IBOutlet private weak var newsDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(imageURL: String?, title: String?, dateStr:String?) {
        newsTitle.text = title ?? ""
        newsDate.text = dateStr?.UTCToLocal() ?? ""
        if let imageURL = imageURL {
            newsImage.setImageWith(url: imageURL)
        }
    }
}
