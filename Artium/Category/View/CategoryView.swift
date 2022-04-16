//
//  CategoryView.swift
//  Artium
//
//  Created by Dileep Jaiswal on 15/04/22.
//

import UIKit

protocol CategoryViewDelegate {
    func didSelectCategoryWith(value: String)
}

@IBDesignable
class CategoryView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var categoryViewModel = CategoryViewModel()
    var delegate: CategoryViewDelegate?
    
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
        bundle.loadNibNamed("CategoryView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        initCollectionView()
        //apply defined layout to collectionview
        collectionView.collectionViewLayout = collectionViewLayout()
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        //Get device width
        let width = UIScreen.main.bounds.width
        
        //set section inset as per your requirement.
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        //set cell item size here
        layout.itemSize = CGSize(width: width / 3, height: 50)
        
        //set Minimum spacing between 2 items
        layout.minimumInteritemSpacing = 1

        layout.scrollDirection = .horizontal
        //set minimum vertical line spacing here between two lines in collectionview
        layout.minimumLineSpacing = 1
        return layout
    }
    
    private func initCollectionView() {
        let nib = UINib(nibName: "CategoryCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CategoryCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        categoryViewModel.delegate = self
        DispatchQueue.main.async {
            ActivityIndicator.start()
        }
        categoryViewModel.getCategoryList()
    }
}

extension CategoryView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else {
            fatalError("can't dequeue CustomCell")
        }
        let category = categoryViewModel.getCategory(index: indexPath.row)
        cell.configureCellWith(value: category.uppercased())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categoryViewModel.getCategory(index: indexPath.row)
        self.delegate?.didSelectCategoryWith(value: category)
    }
}

extension CategoryView: CategoryViewModelDelegate {
    func loadCategorySuccessfully() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            ActivityIndicator.stop()
        }
    }
    
    func failedToLoadCategory(error: NetworkError) {
        
    }
}
