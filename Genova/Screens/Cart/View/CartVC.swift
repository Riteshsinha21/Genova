//
//  CartVC.swift
//  Genova
//
//  Created by CTS on 08/04/24.
//

import UIKit

class CartVC: UIViewController {

    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var cartTableView: UITableView!
    
    private var cartVM = CartViewModel()
    var dummyCartDataArray: [ProductList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
    }
    
    @IBAction func onClickCheckout(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CheckoutVC") as! CheckoutVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension CartVC {
    
    func configuration() {
        
        cartTableView.register(UINib(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "CartCell")
        setTotalPrice()
    }
    
    func setTotalPrice() {
        let totalPrice = dummyCartDataArray.reduce(0.0) { result, item in
            let price = Double(item.discountedPrice ?? "0.0") ?? 0.0
            let quantity = Double(item.quantity ?? 0)
            return result + (price * quantity)
        }
        self.totalPriceLbl.text = "\(totalPrice)"
    }

}

extension CartVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyCartDataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartCell else {
            return UITableViewCell()
        }
        let info = dummyCartDataArray[indexPath.row]
        cell.productList = info
        cell.setIndexPath(indexPath)
        cell.addHandler = { indexPath in
            // Handle add button tap
            let infoToBeUpdated = SharedData.shared.dummyCartDataArray[indexPath!.row]
            self.cartVM.addDummyData(infoToBeUpdated)
            self.dummyCartDataArray = SharedData.shared.dummyCartDataArray
            self.setTotalPrice()
            self.cartTableView.reloadData()
            
        }
        
        cell.removeHandler = { indexPath in
            // Handle add button tap
            let infoToBeUpdated = SharedData.shared.dummyCartDataArray[indexPath!.row]
            self.cartVM.removeDummyData(at: indexPath!)
            self.dummyCartDataArray = SharedData.shared.dummyCartDataArray
            self.setTotalPrice()
            self.cartTableView.reloadData()
            
        }
        return cell
    }
    
}
