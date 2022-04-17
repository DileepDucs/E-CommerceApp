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
    
    override var shouldAutorotate: Bool {
        false
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
        verticalTray.filterTrayWithCategories(list: [value])
    }
}

extension HomeViewController: SortFilterViewDelegate {

    func didSelectSort() {
        let items = ["Clear All", "Price", "Rating"]
        didSelectHelper(title: "Sort By", items: items, filter: false)
    }
    
    func didSelectfilter() {
        var items = categoryView.categoryViewModel.categoryList
        items.removeFirst()
        items.insert("Clear All", at: 0)
        didSelectHelper(title: "Filter", items: items, filter: true)
    }
    
    func didSelectHelper(title: String, items: [String], filter: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MultiSelectionViewController") as! MultiSelectionViewController
        vc.delegate = self
        vc.screenTitle = title
        vc.items = items
        vc.filter = filter
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: MultiSelectionVCDelegate {
    func filterProductsWithSelected(items: [String]) {
        categoryView.reloadSelectedTabWith(index: 0)
        verticalTray.filterTrayWithCategories(list: items)
    }
    
    func sortProductWithSelected(item: String) {
        categoryView.reloadSelectedTabWith(index: 0)
        verticalTray.sortProductWithSelected(item: item)
    }
}
