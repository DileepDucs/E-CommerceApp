//
//  VerticalTray.swift
//  Artium
//
//  Created by Dileep Jaiswal on 15/04/22.
//

import UIKit

@IBDesignable
class VerticalTray: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel = ProductViewModel()
    
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
        bundle.loadNibNamed("VerticalTray", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .lightGray
        initCollectionView()
    }
    
    private func initCollectionView() {
        let nib = UINib(nibName: "VerticalCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "VerticalCell")
        collectionView.dataSource = self
        DispatchQueue.main.async {
            ActivityIndicator.start()
        }
        viewModel.delegate = self
        viewModel.getProductList()
    }
}

extension VerticalTray: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalCell", for: indexPath) as? VerticalCell else {
            fatalError("can't dequeue CustomCell")
        }
        let product = viewModel.getProduct(index: indexPath.row)
        cell.configureCellWith(product: product)
        return cell
    }
}

extension VerticalTray: ProductViewModelDelegate {
    func loadProductSuccessfully() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            ActivityIndicator.stop()
        }
    }
    
    func failedToLoadProductList(error: NetworkError) {
        
    }
}
