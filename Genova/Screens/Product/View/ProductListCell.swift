//
//  ProductListCell.swift
//  Genova
//
//  Created by CTS on 08/04/24.
//

import UIKit

class ProductListCell: UICollectionViewCell {
    
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var productTitleLbl: UILabel!
    @IBOutlet weak var productCatLbl: UILabel!
    @IBOutlet weak var prodImg: UIImageView!
    
    var productList: ProductList? {
        didSet { // Property Observer
            setProductList()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setProductList() {
        guard let productList else { return }
        
        productTitleLbl.text = productList.title
        productCatLbl.text = productList.catType
        productPriceLbl.text = productList.discountedPrice
        discountLbl.text = "\(productList.discount ?? 0) % OFF"
        prodImg.image = UIImage(named: productList.image ?? "Screenshot@1")
    }

}
