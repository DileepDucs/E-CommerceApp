//
//  CategoryViewModel.swift
//  Artium
//
//  Created by Dileep Jaiswal on 15/04/22.
//

import Foundation

// MARK: - SearchViewModelDelegate protocol
protocol CategoryViewModelDelegate {
    func loadCategorySuccessfully()
    func failedToLoadCategory(error: NetworkError)
}

class CategoryViewModel {
    
    // MARK: - Properties
    var delegate: CategoryViewModelDelegate?
    var apiClient = APIClient()
    var categoryList = [String]()
    
    // Category
    
    func getCategoryList() {
        let categoryRequest = CategoryRequest.getProductCategories
        apiClient.fetch(request: categoryRequest, basePath: NetworkConstant.ProductBase.url, keyDecodingStrategy: .useDefaultKeys) { (result: Result<[String], NetworkError>) in
            switch result {
            case .success(let list):
                self.categoryList = list
                self.delegate?.loadCategorySuccessfully()
            case .failure(let error):
                self.delegate?.failedToLoadCategory(error: error)
            }
        }
    }
    
    // This var retun the category list count
    var count: Int  {
        return categoryList.count
    }
    
    // This function retturn category string for the given index.
    func getCategory(index: Int) -> String {
        return categoryList[index]
    }
        
}
