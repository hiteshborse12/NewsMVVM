//
//  NewsDetailViewController.swift
//  News
//
//  Created by Neosoft on 12/08/22.
//

import UIKit

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
    }
    //MARK: SetupView
    private func setupView(){
        self.title = viewModel.getTitle()
        setupNewsView()
    }
    private func setupNewsView(){
        let selectedNews = viewModel.getNews()
    }
}
