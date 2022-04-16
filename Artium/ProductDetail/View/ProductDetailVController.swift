//
//  ProductDetailVController.swift
//  Artium
//
//  Created by Dileep Jaiswal on 15/04/22.
//

import UIKit

class ProductDetailVController: UIViewController {
    
    var product: Product?
    var viewModel = ProductDetailModel()
    var productId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.delegate = self
        DispatchQueue.main.async {
            ActivityIndicator.start()
        }
        viewModel.getProductDetailWith(productId: productId)
    }
}

extension ProductDetailVController: ProductDetailModelDelegate {
    func loadProductDetailSuccessfullyWith(detail: Product) {
        product = detail
        DispatchQueue.main.async {
            ActivityIndicator.stop()
        }
    }
    
    func failedToLoadProductDetail(error: NetworkError) {
        DispatchQueue.main.async {
            ActivityIndicator.stop()
        }
    }
    
}
