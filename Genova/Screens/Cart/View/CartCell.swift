//
//  CartCell.swift
//  Genova
//
//  Created by CTS on 09/04/24.
//

import UIKit

class CartCell: UITableViewCell {

    @IBOutlet weak var incrementBtn: UIButton!
    @IBOutlet weak var decrementBtn: UIButton!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var catTitlelbl: UILabel!
    @IBOutlet weak var catTypeLbl: UILabel!
    @IBOutlet weak var prodImg: UIImageView!
    
    var productList: ProductList? {
        didSet { // Property Observer
            setProductList()
        }
    }
    
    var indexPath: IndexPath?
    var addHandler: ((IndexPath?) -> Void)?
    var removeHandler: ((IndexPath?) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setProductList() {
        guard let productList else { return }
        
        catTitlelbl.text = productList.title
        catTypeLbl.text = productList.catType
        priceLbl.text = productList.discountedPrice
        quantityLbl.text = "\(productList.quantity ?? 1)"
        prodImg.image = UIImage(named: productList.image ?? "Screenshot@1")
    }
    
    func setIndexPath(_ indexPath: IndexPath) {
            self.indexPath = indexPath
        }
    
    @IBAction func onClickDecrease(_ sender: Any) {
        if let indexPath = indexPath {
            removeHandler?(indexPath)
        }
    }
    
    @IBAction func onClickIncrease(_ sender: Any) {
        if let indexPath = indexPath {
            addHandler?(indexPath)
        }
    }
    
    
}
