//
//  CartViewModel.swift
//  Genova
//
//  Created by CTS on 08/04/24.
//

import Foundation

final class CartViewModel {
    
    internal let sharedData = SharedData.shared
    private var dummyCartDataArray: [ProductList] = []
    var onDataUpdated: ((_ canAddData: Bool) -> Void)?
    
    init() {
            self.dummyCartDataArray = []
        }
    func addDummyData(_ dummyData: ProductList) {
        // Check if the item is already present in the array
        if let existingItemIndex = sharedData.dummyCartDataArray.firstIndex(where: { $0.id == dummyData.id }) {
            // If the item exists, increase its quantity by 1
            sharedData.dummyCartDataArray[existingItemIndex].quantity! += 1
        } else {
            // If the item doesn't exist, add it to the array
            sharedData.dummyCartDataArray.append(dummyData)
        }
    }
    func removeDummyData(_ dummyData: ProductList) {
        // Check if the item is already present in the array
        if let existingItemIndex = sharedData.dummyCartDataArray.firstIndex(where: { $0.id == dummyData.id }) {
            // If the item exists, remove it from the array
            sharedData.dummyCartDataArray.remove(at: existingItemIndex)
        } else {
            // If the item doesn't exist, print a message
            print("Item not found in array")
        }
    }
    
    func calculateTotalPrice() -> Double {
        let totalPrice = sharedData.dummyCartDataArray.reduce(0.0) { result, item in
            let price = Double(item.discountedPrice ?? "0.0") ?? 0.0
            let quantity = Double(item.quantity ?? 0)
            return result + (price * quantity)
        }
        return totalPrice
    }
    
    func removeDummyData(at indexPath: IndexPath) {
        let item = sharedData.dummyCartDataArray[indexPath.row]
        if item.quantity == 1 {
            sharedData.dummyCartDataArray.remove(at: indexPath.row)
        } else {
            sharedData.dummyCartDataArray[indexPath.row].quantity! -= 1
        }
        // Notify the view that the data has been updated
    }
    
    func getDummyDataArray() -> [ProductList] {
        return sharedData.dummyCartDataArray
    }
    
    func createDummyJSON() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let jsonData = try encoder.encode(sharedData.dummyCartDataArray)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print("Error encoding objects to JSON: \(error)")
            return nil
        }
    }

}
