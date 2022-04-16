//
//  ProductDetailModel.swift
//  Artium
//
//  Created by Dileep Jaiswal on 16/04/22.
//

import Foundation


// MARK: - SearchViewModelDelegate protocol
protocol ProductDetailModelDelegate {
    func loadProductDetailSuccessfullyWith(detail: Product)
    func failedToLoadProductDetail(error: NetworkError)
}

class ProductDetailModel {
    
    // MARK: - Properties
    var delegate: ProductDetailModelDelegate?
    var apiClient = APIClient()
    
    // Product:-
    
    func getProductDetailWith(productId: Int) {
        let productRequest = ProductRequest.getProductDetail(productId: productId)
        apiClient.fetch(request: productRequest, basePath: NetworkConstant.ProductBase.url, keyDecodingStrategy: .useDefaultKeys) { (result: Result<Product, NetworkError>) in
            switch result {
            case .success(let product):
                self.delegate?.loadProductDetailSuccessfullyWith(detail: product)
            case .failure(let error):
                self.delegate?.failedToLoadProductDetail(error: error)
            }
        }
    }
}
