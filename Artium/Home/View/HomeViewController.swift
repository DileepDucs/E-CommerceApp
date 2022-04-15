//
//  HomeViewController.swift
//  Artium
//
//  Created by Dileep Jaiswal on 13/04/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var horizontalTray: HorizontalTray!
    @IBOutlet weak var verticalTray: VerticalTray!
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 10, width: Utility.screenWidth - 30, height: 40))
        searchBar.placeholder = "Search your item"
        searchBar.delegate = self
        return searchBar
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        verticalTray.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupNavigationBar() {
        let navigationBar = UIBarButtonItem(customView: searchBar)
        navigationItem.leftBarButtonItem = navigationBar
    }
    
    /// This function navigate to the search detail screen.
    private func pushProductDetailsViewController() {
        let detailViewController = ProductDetailVController()
        navigationController?.pushViewController(detailViewController, animated: true)
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


extension HomeViewController: VerticalTrayDelegate {
    func didSelectProductWith(product: Product) {
        let detailViewController = ProductDetailVController()
        detailViewController.product = product
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
