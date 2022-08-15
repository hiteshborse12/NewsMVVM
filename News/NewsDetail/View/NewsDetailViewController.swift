//
//  NewsDetailViewController.swift
//  News
//
//  Created by Neosoft on 12/08/22.
//

import UIKit
import SafariServices

class NewsDetailViewController: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var newsimageView: UIImageView!
    @IBOutlet weak var newsLable: UILabel!
    @IBOutlet weak var newsDateLable: UILabel!
    @IBOutlet weak var newsDescLable: UILabel!
    @IBOutlet weak var newsAuthorLable: UILabel!
    
    var  viewModel:NewsDetailViewModelProtocol

    //MARK: Init
    init(viewModel:NewsDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: View Life cyle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    //MARK: SetupView
    private func setupView(){
        self.title = viewModel.getTitle()
        setupNewsView()
    }
    private func setupNewsView(){
        let selectedNews = viewModel.getNews()
        newsLable.text = selectedNews.title
        newsDescLable.text = selectedNews.articleDescription
        if let datestr = selectedNews.publishedAt?.UTCToLocal(){
            newsDateLable.text = "Published:\(datestr)"
        }
        if let authorstr = selectedNews.author{
            newsAuthorLable.text = "By:\(authorstr)"
        }
        if let imageUrl = selectedNews.urlToImage{
            newsimageView.setImageWith(url: imageUrl)
        }else{
            newsimageView.image = #imageLiteral(resourceName: "Placeholder")
        }
    }
    //MARK: - Actions
    @IBAction private func safariButonAction(_ sender: CustomButton) {
         openSafariView()
    }
    //MARK: - Open news in Safari
    func openSafariView() {
        guard let url = viewModel.getNewsUrl() else { return }
        let safari = SFSafariViewController(url: url)
        present(safari, animated: true)
    }
}
