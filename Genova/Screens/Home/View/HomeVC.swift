//
//  HomeVC.swift
//  Genova
//
//  Created by CTS on 08/04/24.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var categoryCollView: UICollectionView!
    @IBOutlet weak var youMayLikeCollView: UICollectionView!
    
    private var homeVM = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configuration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}

extension HomeVC {
    
    func configuration() {
        youMayLikeCollView.register(UINib(nibName: "youMayLikeCell", bundle: nil), forCellWithReuseIdentifier: "youMayLikeCell")
        categoryCollView.register(UINib(nibName: "youMayLikeCell", bundle: nil), forCellWithReuseIdentifier: "youMayLikeCell")
        initViewModel()
        title = "GENOVA"
    }
    
    func initViewModel() {
        homeVM.fetchYouMayLikeData {
            DispatchQueue.main.async {
                print(self.homeVM.youMaylikeCatArr)
                self.youMayLikeCollView.reloadData()
            }
        }
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.youMayLikeCollView {
            return homeVM.youMaylikeCatArr.count
        } else {
            return homeVM.youMaylikeCatArr.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.youMayLikeCollView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "youMayLikeCell", for: indexPath) as? youMayLikeCell else {
                return UICollectionViewCell()
            }
            let info = homeVM.youMaylikeCatArr[indexPath.row]
            cell.productList = info
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "youMayLikeCell", for: indexPath) as? youMayLikeCell else {
                return UICollectionViewCell()
            }
            let info = homeVM.youMaylikeCatArr[indexPath.row]
            cell.productList = info
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductListVC") as! ProductListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.youMayLikeCollView {
            let screenSize              = collectionView.frame.size
            let screenWidth             = screenSize.width
            let cellSquareSize: CGFloat = (screenWidth / 3.0) - 5
            return CGSize.init(width: 150, height: 150)
        } else {
            let screenSize              = collectionView.frame.size 
            let screenWidth             = screenSize.width
            let cellSquareSize: CGFloat = (screenWidth / 2.0) - 5
            return CGSize.init(width: cellSquareSize, height: (screenSize.height / 2.0) - 5)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.youMayLikeCollView {
            return UIEdgeInsets(top: 0, left: 0, bottom: CGFloat(5), right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 5, bottom: CGFloat(5), right: 0)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.youMayLikeCollView {
            return 5
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.youMayLikeCollView {
            return 5
        } else {
            return 0
        }
        
    }
}
