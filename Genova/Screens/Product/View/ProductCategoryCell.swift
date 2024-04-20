//
//  ProductCategoryCell.swift
//  Genova
//
//  Created by CTS on 08/04/24.
//

import UIKit

class ProductCategoryCell: UICollectionViewCell {

    @IBOutlet weak var catTitle: UILabel!
    
    var productCat: ProductCategory? {
        didSet { // Property Observer
            setProductCat()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setProductCat() {
        guard let productCat else { return }
        
        catTitle.text = productCat.title
    }

}
