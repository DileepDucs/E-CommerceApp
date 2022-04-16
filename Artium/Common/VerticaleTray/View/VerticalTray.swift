//
//  VerticalTray.swift
//  Artium
//
//  Created by Dileep Jaiswal on 15/04/22.
//

import UIKit

protocol VerticalTrayDelegate {
    func didSelectProductWith(product: Product)
}

@IBDesignable
class VerticalTray: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel = ProductViewModel()
    var delegate: VerticalTrayDelegate?
    
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
        collectionView.delegate = self
        DispatchQueue.main.async {
            ActivityIndicator.start()
        }
        viewModel.delegate = self
        viewModel.getProductList()
        //apply defined layout to collectionview
        collectionView.collectionViewLayout = collectionViewLayout()
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        //Get device width
        let width = UIScreen.main.bounds.width - 11
        
        //set section inset as per your requirement.
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 2, right: 5)
        
        //set cell item size here
        layout.itemSize = CGSize(width: width / 2, height: width / 1.7)
        
        //set Minimum spacing between 2 items
        layout.minimumInteritemSpacing = 1
        
        //set minimum vertical line spacing here between two lines in collectionview
        layout.minimumLineSpacing = 1
        return layout
    }
    
}

extension VerticalTray: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = viewModel.getProduct(index: indexPath.row)
        delegate?.didSelectProductWith(product: product)
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
