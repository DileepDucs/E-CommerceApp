//
//  HomeViewModel.swift
//  Artium
//
//  Created by Dileep Jaiswal on 13/04/22.
//

import Foundation


// MARK: - SearchViewModelDelegate protocol
protocol HomeViewModelDelegate {
    func githubSearchSuccessfully()
    func githubSearchFailure()
}

class HomeViewModel {
    
    // MARK: - Properties
    var delegate: HomeViewModelDelegate?
    var apiClient = APIClient()
    var searchItems = [SearchItem]()
    
    func getProductList() {
        let apiData = ProductRequest.getProductList
        apiClient.fetch(request: apiData, basePath: NetworkConstant.Product.url, success: { (data, result) in
            self.parse(dataResponse: data)
        }) { (data, result, error) in
            print("Error", error.localizedDescription)
            self.delegate?.githubSearchFailure()
        }
    }
    
    func getCategoryList() {
        let apiData = CategoryRequest.getProductCategories
        apiClient.fetch(request: apiData, basePath: NetworkConstant.Search.url, success: { (data, result) in
            self.parse(dataResponse: data)
        }) { (data, result, error) in
            print("Error", error.localizedDescription)
            self.delegate?.githubSearchFailure()
        }
    }
        
    // This function will fetch list of items on the search of name
    func fetchSearchList(name: String) {
        let apiData = SearchRequest.searchByName(name)
        apiClient.fetch(request: apiData, basePath: NetworkConstant.Search.url, success: { (data, result) in
            self.parse(dataResponse: data)
        }) { (data, result, error) in
            print("Error", error.localizedDescription)
            self.delegate?.githubSearchFailure()
        }
    }
    
    // This func parse jsn response from the server and store items in variables.
    func parse(dataResponse: Data) {
        do {
            //here dataResponse received from a network request
            let decoder = JSONDecoder()
            let githubSearch = try decoder.decode(GithubSearch.self, from: dataResponse)
            searchItems.removeAll()
            if let items = githubSearch.items {
                searchItems = items
            }
            self.delegate?.githubSearchSuccessfully()
        } catch let parsingError {
            print("Error", parsingError)
            self.delegate?.githubSearchFailure()
        }
    }
    
    
    // This function retun the search items count
    func searchListCount() -> Int {
        return searchItems.count
    }
    
    // This function retturn search object for the given index.
    func getSearchItemWith(index: Int) -> SearchItem {
        return searchItems[index]
    }
}
