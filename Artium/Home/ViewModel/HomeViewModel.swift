//
//  HomeViewModel.swift
//  Artium
//
//  Created by Dileep Jaiswal on 13/04/22.
//

import Foundation


// MARK: - SearchViewModelDelegate protocol
protocol HomeViewModelDelegate {
    func loadProductSuccessfully()
    func failedToLoadProductList(error: NetworkError)
}

class HomeViewModel {
    
    // MARK: - Properties
    var delegate: HomeViewModelDelegate?
    var apiClient = APIClient()
    var productItems = [Product]()
    
    // Product:-
    
    func getProductList() {
        let productRequest = ProductRequest.getProductList
        apiClient.fetch(request: productRequest, basePath: NetworkConstant.ProductBase.url, keyDecodingStrategy: .useDefaultKeys) { (result: Result<[Product], NetworkError>) in
            switch result {
            case .success(let list):
                self.productItems = list
                self.delegate?.loadProductSuccessfully()
            case .failure(let error):
                self.delegate?.failedToLoadProductList(error: error)
            }
        }
    }
    
    // This var retun the product items count
    var count: Int  {
        return self.productItems.count
    }
    
    // This function retturn product object for the given index.
    func getProduct(index: Int) -> Product{
        return productItems[index]
    }
}
