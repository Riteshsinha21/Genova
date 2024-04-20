//
//  ProductModel.swift
//  Genova
//
//  Created by CTS on 08/04/24.
//

import Foundation

struct ProductCategory: Decodable {
    let id: Int?
    let title: String?
}

struct ProductList: Codable {
    let id: Int?
    let catType: String?
    let title: String?
    let image: String?
    let originalPrice: String?
    let discountedPrice: String?
    let discount: Int?
    var quantity: Int?
}

