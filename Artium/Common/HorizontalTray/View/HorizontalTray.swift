//
//  HorizontalTray.swift
//  Artium
//
//  Created by Dileep Jaiswal on 15/04/22.
//

import UIKit

@IBDesignable

class HorizontalTray: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var categoryViewModel = CategoryViewModel()
    
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
        bundle.loadNibNamed("HorizontalTray", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .red
        initCollectionView()
    }
    
    private func initCollectionView() {
        let nib = UINib(nibName: "HorizontalCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "HorizontalCell")
        collectionView.dataSource = self
        categoryViewModel.delegate = self
        DispatchQueue.main.async {
            ActivityIndicator.start()
        }
        categoryViewModel.getCategoryList()
    }
}

extension HorizontalTray: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalCell", for: indexPath) as? HorizontalCell else {
            fatalError("can't dequeue CustomCell")
        }
        let item = categoryViewModel.getCategory(index: indexPath.row)
        cell.backgroundColor = .green
        return cell
    }
}

extension HorizontalTray: CategoryViewModelDelegate {
    func loadCategorySuccessfully() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            ActivityIndicator.stop()
        }
    }
    
    func failedToLoadCategory(error: NetworkError) {
        
    }
}
