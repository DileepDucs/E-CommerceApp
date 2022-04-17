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
    @IBOutlet weak var sortFilterView: SortFilterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        verticalTray.delegate = self
        categoryView.delegate = self
        sortFilterView.delegate = self
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
    private func pushProductDetailsViewController(product: Product) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "ProductDetailVController") as! ProductDetailVController
        detailVC.productId = product.id
        self.navigationController?.pushViewController(detailVC, animated: true)
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
        pushProductDetailsViewController(product: product)
    }
}

extension HomeViewController: CategoryViewDelegate {
    func didSelectCategoryWith(value: String) {
        verticalTray.filterTrayWith(category: value)
    }
}

extension HomeViewController: SortFilterViewDelegate {
    func didSelectSort() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MultiSelectionViewController") as! MultiSelectionViewController
        vc.screenTitle = "Filter"
        vc.items = ["Price", "Rating"]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didSelectfilter() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MultiSelectionViewController") as! MultiSelectionViewController
        vc.screenTitle = "Sort By"
        var items = categoryView.categoryViewModel.categoryList
        items.insert("All Clear", at: 0)
        vc.items = items
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
