//
//  HomeViewController.swift
//  Artium
//
//  Created by Dileep Jaiswal on 13/04/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var categoryView: CategoryView!
    @IBOutlet weak var verticalTray: VerticalTray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        verticalTray.delegate = self
        categoryView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupSearchBar() {
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search your item"
        searchBar.delegate = self
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
        searchBar.endEditing(true)
    }
}

extension HomeViewController: VerticalTrayDelegate {
    func didSelectProductWith(product: Product) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "ProductDetailVController") as! ProductDetailVController
        detailVC.productId = product.id
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension HomeViewController: CategoryViewDelegate {
    func didSelectCategoryWith(value: String) {
        verticalTray.filterTrayWith(category: value)
    }
}
