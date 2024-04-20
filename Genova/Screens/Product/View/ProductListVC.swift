//
//  ProductListVC.swift
//  Genova
//
//  Created by CTS on 08/04/24.
//

import UIKit

class ProductListVC: UIViewController {
    
    @IBOutlet weak var productListCollView: UICollectionView!
    @IBOutlet weak var productCatCollView: UICollectionView!
    
    internal var productVM = ProductViewModel()
    private var cartVM = CartViewModel()
    var badgeLabel: UILabel!
    var badgeCount = SharedData.shared.dummyCartDataArray.count
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configuration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        setCartBadge()
    }
    
    
    
}

extension ProductListVC {
    
    func configuration() {
        productListCollView.register(UINib(nibName: "ProductListCell", bundle: nil), forCellWithReuseIdentifier: "ProductListCell")
        productCatCollView.register(UINib(nibName: "ProductCategoryCell", bundle: nil), forCellWithReuseIdentifier: "ProductCategoryCell")
        initViewModel()
        createRightBarButton()
    }
    
    func setCartBadge() {
        badgeCount = SharedData.shared.dummyCartDataArray.count
        badgeLabel.text = "\(String(describing: badgeCount))"
    }
    
    func createRightBarButton() {
        // Create a custom button
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "cart"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        
        // Create a custom view to hold the button and the badge label
        let containerView = UIView(frame: button.frame)
        containerView.addSubview(button)
        
        // Create a badge label
        badgeLabel = UILabel(frame: CGRect(x: button.frame.size.width - 12, y: -2, width: 20, height: 20))
        badgeLabel.layer.cornerRadius = badgeLabel.bounds.size.height / 2
        badgeLabel.layer.masksToBounds = true
        badgeLabel.backgroundColor = UIColor.red
        badgeLabel.textColor = UIColor.white
        badgeLabel.textAlignment = .center
        badgeLabel.font = UIFont.systemFont(ofSize: 12)
        badgeLabel.text = "\(badgeCount)" // Set your badge count here
        
        // Add badge label to the container view
        containerView.addSubview(badgeLabel)
        
        // Create a bar button item with the custom view
        let cartButton = UIBarButtonItem(customView: containerView)
        
        // Add the bar button item to the navigation bar
        navigationItem.title = "Product List"
        navigationItem.rightBarButtonItem = cartButton
    }
    
    @objc func cartButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let destinationViewController = storyboard.instantiateViewController(withIdentifier: "CartVC") as? CartVC {
            destinationViewController.dummyCartDataArray = cartVM.getDummyDataArray()
            self.navigationController?.pushViewController(destinationViewController, animated: true)
        }
    }
    
    func initViewModel() {
        
        let group = DispatchGroup()
        
        group.enter()
        productVM.fetchProductCategory {
            group.leave()
        }
        
        group.enter()
        productVM.fetchProductList {
            group.leave()
        } errorHandler: {
            error in
            print(error.localizedDescription)
        }
        
        group.notify(queue: .main) {
            self.productListCollView.reloadData()
            self.productCatCollView.reloadData()
        }
       
    }
}

extension ProductListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productCatCollView {
            return productVM.productCatArr.count
        } else {
            return productVM.productListArr.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productCatCollView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCategoryCell", for: indexPath) as? ProductCategoryCell else {
                return UICollectionViewCell()
            }
            let info = productVM.productCatArr[indexPath.row]
            cell.productCat = info
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: indexPath) as? ProductListCell else {
                return UICollectionViewCell()
            }
             let info = productVM.productListArr[indexPath.row]
            cell.productList = info
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == productCatCollView {

        } else {
            
            let info = productVM.productListArr[indexPath.row]
            var dummyData = ProductList(id: info.id, catType: info.catType, title: info.title, image: info.image, originalPrice: info.originalPrice, discountedPrice: info.discountedPrice, discount: info.discount, quantity: (info.quantity ?? 0) + 1)
            cartVM.addDummyData(dummyData)
            badgeCount = SharedData.shared.dummyCartDataArray.count
            badgeLabel.text = "\(String(describing: badgeCount))"
            self.view.showToast(message: "Item added to Cart.")
            
            
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Section insets (distance from boundary )
        if collectionView == self.productCatCollView {
            
            return UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
        }else{
            return UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10)}
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == self.productCatCollView {
            
            return 30
        }
        return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == self.productCatCollView {
            
            return 30
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // get the Collection View width and height
        if collectionView == self.productCatCollView {
            let collectionViewWidth = productCatCollView.frame.width
            let cellWidth = (collectionViewWidth - 50 ) / 4
            
            return CGSize(width: cellWidth , height: 40)
        }else {
            let collectionViewWidth = productListCollView.frame.width
            
            let cellWidth = (collectionViewWidth - 30 ) / 2
            
            return CGSize(width: cellWidth , height: 250)
        }
        
        
    }
    
}
