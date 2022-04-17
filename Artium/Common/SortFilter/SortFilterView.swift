//
//  SortFilterView.swift
//  Artium
//
//  Created by Dileep Jaiswal on 16/04/22.
//

import UIKit

protocol SortFilterViewDelegate {
    func didSelectSort()
    func didSelectfilter()
}

@IBDesignable
class SortFilterView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var sortButton: UIButton!
    var delegate: SortFilterViewDelegate?
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
        bundle.loadNibNamed("SortFilterView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @IBAction func sortButtonTapped(_ sender: UIButton) {
        delegate?.didSelectSort()
    }
    
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        delegate?.didSelectfilter()
    }
    
}
