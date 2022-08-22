//
//  NewsListViewControllerExtension.swift
//  News
//
//  Created by Neosoft on 22/08/22.
//

import Foundation
import UIKit
///NewsListViewController extension for tableview
//MARK: UITableViewDelegate
extension NewsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.getNewsCount() - 1 {
            viewModel.loadMoreNews()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let news = viewModel.getNews(at: indexPath.row){
            let newsDetailViewModel = NewsDetailViewModel(news: news)
            let newsDetailViewController = NewsDetailViewController(viewModel: newsDetailViewModel)
            self.push(viewController: newsDetailViewController)
        }
    }
}
//MARK: UITableViewDataSource
extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNewsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as NewsTableViewCell
        cell.accessibilityIdentifier = "NewsTableViewCell_\(indexPath.row)"
        if let news = viewModel.getNews(at: indexPath.row){
            cell.configureCell(imageURL: news.urlToImage, title: news.title, dateStr: news.publishedAt)
        }
        return cell
    }
}
