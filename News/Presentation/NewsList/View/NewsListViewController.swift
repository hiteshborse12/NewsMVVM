//
//  NewsListViewController.swift
//  News
//
//  Created by Neosoft on 11/08/22.
//

import UIKit

class NewsListViewController: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var searchBar: CustomSearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: NewsListViewModelProtocol
    private var footerActivityIndicator: UIActivityIndicatorView?
    
    //MARK: Init
    init(viewModel: NewsListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View Life cyle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        bindViewModel()
        viewModel.fetchNews()
    }
    
    //MARK: SetupView
    private func setupView(){
        self.navigationItem.backButtonTitle = StringConstants.backTitle
        self.title = viewModel.getTitle()
        setupAccessibilityIdentifier()
        setupTableView()
        setupSearchBar()
    }
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(cellClass: NewsTableViewCell.self)
    }
    func setupSearchBar() {
        searchBar.textDidChange = {[weak self] text in
            guard let self = self else { return}
            self.viewModel.searchForArticle(by: text)
        }
    }
    func setupAccessibilityIdentifier(){
        self.tableView.accessibilityIdentifier = "newsListTableView"
        self.searchBar.accessibilityIdentifier = "newsListSearchBar"
    }
    //MARK: Show loding Bar
    private func showLoading() {
        tableView.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
    }
    //MARK: Hide loding Bar
    func dismissLoading() {
        tableView.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
    }
    //MARK: Reload Data
    private  func reloadData() {
        removeIndicators()
        tableView.isHidden = false
        tableView.reloadData()
    }
    //MARK: Hide footer activity indicator
    private func removeIndicators() {
        tableView.removeActivityIndicatorFromFooter(footerActivityIndicator)
        dismissLoading()
    }
    
}
//MARK: Bind viewModel
extension NewsListViewController {
    private func bindViewModel(){
        viewModel.getLoadingState = { state in
            switch state{
            case .loading:
                self.showLoading()
            case .loadingMore:
                //Show footer activity indicator
                self.footerActivityIndicator = self.tableView.showActivityIndicatorInFooter()
            case .error(let error):
                self.reloadData()
                self.show(error: error)
            case .empty:
                //Show empty view
                self.tableView.setEmptyView(title: StringConstants.noNews)
            case .populated:
                self.tableView.restore()
                self.reloadData()
            }
        }
    }
}

