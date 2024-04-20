//
//  youMayLikeCell.swift
//  Genova
//
//  Created by CTS on 08/04/24.
//

import UIKit

class youMayLikeCell: UICollectionViewCell {

    @IBOutlet weak var prodImg: UIImageView!
    
    var productList: YouMayLikeCategory? {
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
        
        prodImg.image = UIImage(named: productList.image ?? "Screenshot@1")
    }

}
