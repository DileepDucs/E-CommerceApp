//
//  VerticalCell.swift
//  Artium
//
//  Created by Dileep Jaiswal on 15/04/22.
//

import UIKit

class VerticalCell: UICollectionViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCellWith(product: Product) {
        nameLabel.text = product.title
        categoryLabel.text = product.category?.capitalized
        self.backgroundColor = .orange
    }

}
