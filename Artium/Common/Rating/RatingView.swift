//
//  RatingView.swift
//  Artium
//
//  Created by Dileep Jaiswal on 16/04/22.
//

import UIKit

@IBDesignable
class RatingView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var curveView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("RatingView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .clear
        curveView.layer.cornerRadius = 10.0
    }
    
    func setRatingValue(rating: Rating?) {
        guard let rating = rating else { return }
        ratingLabel.text = "\(rating.rate)"
        countLabel.text = "\(rating.count)"
    }
}
