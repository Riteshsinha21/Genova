//
//  HomeViewModel.swift
//  Genova
//
//  Created by CTS on 08/04/24.
//

import Foundation

final class HomeViewModel {
    
    var youMaylikeCatArr: [YouMayLikeCategory] = []
    
    func fetchYouMayLikeData(completion: @escaping () -> Void) {
        if let path = Bundle.main.path(forResource: "YouMayLike", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                youMaylikeCatArr = try decoder.decode([YouMayLikeCategory].self, from: data)
                completion() // Call the completion handler once data is loaded
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
    
}
