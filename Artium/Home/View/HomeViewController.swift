//
//  HomeViewController.swift
//  Artium
//
//  Created by Dileep Jaiswal on 13/04/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var horizontalTray: HorizontalTray!
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 10, width: Utility.screenWidth - 30, height: 40))
        searchBar.placeholder = "Search your item"
        searchBar.delegate = self
        return searchBar
    }()
    
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        viewModel.delegate = self
        //viewModel.getProductList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupNavigationBar() {
        let navigationBar = UIBarButtonItem(customView: searchBar)
        navigationItem.leftBarButtonItem = navigationBar
    }
}

// MARK: - UISearchBarDelegate for search action
extension HomeViewController: UISearchBarDelegate {
    
    // This function get called on search button clicked in keyboards and call API to fetch the results.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        //githubSearchItemsWith(name: text)
        //searchBar.endEditing(true)
    }
}


extension HomeViewController: HomeViewModelDelegate {
    func loadProductSuccessfully() {
        
    }
    
    func failedToLoadProductList(error: NetworkError) {
        
    }

}
