//
//  CustomSearchBar.swift
//  News
//
//  Created by Neosoft on 11/08/22.
//

import UIKit

class CustomSearchBar: UISearchBar {

    var textDidChange: ((String) -> Void)?
    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSearchBar()
    }

    private func setupSearchBar() {
        self.delegate = self
        self.searchTextField.clearButtonMode = .never
    }
    
    private func dismissKeyboard(with searchText: String) {
        self.resignFirstResponder()
        self.showsCancelButton = false
        textDidChange?(searchText)
    }
}

extension CustomSearchBar: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.showsCancelButton = true
        textDidChange?(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.text = ""
        dismissKeyboard(with: "")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard(with: searchBar.text ?? "")
    }
    
}
