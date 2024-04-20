//
//  SharedData.swift
//  Genova
//
//  Created by CTS on 09/04/24.
//

import Foundation

class SharedData {
    static let shared = SharedData()

    var dummyCartDataArray: [ProductList]

    private init() {
        dummyCartDataArray = []
    }
}
