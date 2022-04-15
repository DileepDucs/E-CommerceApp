//
//  HorizontalCell.swift
//  Artium
//
//  Created by Dileep Jaiswal on 15/04/22.
//

import UIKit

class HorizontalCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCellWith(value: String) {
        categoryLabel.text = value
        categoryLabel.textColor = .white
    }

}
