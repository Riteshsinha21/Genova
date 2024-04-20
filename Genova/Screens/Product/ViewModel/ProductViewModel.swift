//
//  ProductViewModel.swift
//  Genova
//
//  Created by CTS on 08/04/24.
//

import Foundation

final class ProductViewModel {
    
    var productCatArr: [ProductCategory] = []
    var productListArr: [ProductList] = []
    
    func fetchProductCategory(completion: @escaping () -> Void) {
        if let path = Bundle.main.path(forResource: "ProductCat", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                productCatArr = try decoder.decode([ProductCategory].self, from: data)
                print(productCatArr)
                completion() // Call the completion handler once data is loaded
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
    
    func fetchProductList(completion: @escaping () -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let path = Bundle.main.path(forResource: "ProductList", ofType: "json") else {
            let error = NSError(domain: "YourDomain", code: 404, userInfo: nil)
            print("Error loading file: \(error)")
            errorHandler(error)
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            productListArr = try decoder.decode([ProductList].self, from: data)
            print(productListArr)
        } catch {
            print("Error decoding JSON: \(error)")
            errorHandler(error)
        }
        
        completion()
    }
    
    
    
    
    
    
}
