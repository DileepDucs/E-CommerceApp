//
//  VerticalCell.swift
//  Artium
//
//  Created by Dileep Jaiswal on 15/04/22.
//

import UIKit
import SDWebImage

class VerticalCell: UICollectionViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCellWith(product: Product) {
        imageView.sd_setImage(with: URL(string: product.image ?? ""), placeholderImage: UIImage(named: ""))
        nameLabel.text = product.title
        categoryLabel.text = product.category?.capitalized
        priceLabel.text = "₹\(product.price)"
    }

}
