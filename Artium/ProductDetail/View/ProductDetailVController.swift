//
//  ProductDetailVController.swift
//  Artium
//
//  Created by Dileep Jaiswal on 15/04/22.
//

import UIKit
import SDWebImage

class ProductDetailVController: UIViewController {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
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
    
    private func loadProductView(detail: Product) {
        productImageView.sd_setImage(with: URL(string: detail.image ?? ""))
        DispatchQueue.main.async {
            self.nameLabel.text = detail.title
            self.categoryLabel.text = detail.category?.capitalized
        }
    }
}

extension ProductDetailVController: ProductDetailModelDelegate {
    func loadProductDetailSuccessfullyWith(detail: Product) {
        product = detail
        loadProductView(detail: detail)
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