//
//  CheckoutVC.swift
//  Genova
//
//  Created by CTS on 09/04/24.
//

import UIKit

class CheckoutVC: UIViewController {

    @IBOutlet weak var prodCollView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
    }
    
    @IBAction func onClickPayment(_ sender: Any) {
        let alert = UIAlertController(title: "Congratulations !", message: "Payment Successfull", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            SharedData.shared.dummyCartDataArray.removeAll()
            if let navigationController = self.navigationController {
                // Get the view controller that is 3 view controllers back in the navigation stack
                let viewControllers = navigationController.viewControllers
                let index = max(viewControllers.count - 4, 0) // Adjust the index based on your needs
                let targetViewController = viewControllers[index]
                
                // Pop to the target view controller
                navigationController.popToViewController(targetViewController, animated: true)
            }

        })
        present(alert, animated: true, completion: nil)
        
    }
    
}

extension CheckoutVC {
    
    func configuration() {
        prodCollView.register(UINib(nibName: "ProductListCell", bundle: nil), forCellWithReuseIdentifier: "ProductListCell")
    }

}

extension CheckoutVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SharedData.shared.dummyCartDataArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: indexPath) as? ProductListCell else {
            return UICollectionViewCell()
        }
        if indexPath.row < SharedData.shared.dummyCartDataArray.count {
            let info = SharedData.shared.dummyCartDataArray[indexPath.row]
            cell.productList = info
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize              = collectionView.frame.size //UIScreen.main.bounds
        let screenWidth             = screenSize.width
        return CGSize.init(width: 250, height: 250)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: CGFloat(5), right: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
        
    }
}
