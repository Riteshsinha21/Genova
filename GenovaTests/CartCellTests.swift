//
//  CartCellTests.swift
//  GenovaTests
//
//  Created by CTS on 09/04/24.
//

import XCTest
@testable import Genova

class CartCellTests: XCTestCase {

    var cell: CartCell!

    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: CartCell.self)
        let nib = UINib(nibName: "CartCell", bundle: bundle)
        let objects = nib.instantiate(withOwner: nil, options: nil)
        if let cell = objects.first as? CartCell {
            self.cell = cell
        } else {
            XCTFail("Unable to instantiate CartCell from nib")
        }
    }

    override func tearDown() {
        cell = nil
        super.tearDown()
    }

    func testSetProductList() {
        let productList = ProductList(id: 1, catType: "1", title: "Product 1", image: "product1.png", originalPrice: "10.0", discountedPrice: "8.0", discount: 20, quantity: 1)
        cell.productList = productList

        XCTAssertEqual(cell.catTitlelbl.text, "Product 1", "Product title label should be set to 'Product 1'")
        XCTAssertEqual(cell.catTypeLbl.text, "1", "Product category label should be set to '1'")
        XCTAssertEqual(cell.priceLbl.text, "8.0", "Product price label should be set to '8.0'")
        XCTAssertEqual(cell.quantityLbl.text, "1", "Product quantity label should be set to '1'")
        XCTAssertEqual(cell.prodImg.image, UIImage(named: "product1.png"), "Product image should be set to 'product1.png'")
    }

    func testOnClickDecrease() {
        var indexPath: IndexPath?
        cell.indexPath = IndexPath(row: 0, section: 0)
        cell.removeHandler = { idxPath in
            indexPath = idxPath
        }
        cell.onClickDecrease(UIButton())

        XCTAssertEqual(indexPath, IndexPath(row: 0, section: 0), "Remove handler should be called with correct index path")
    }

    func testOnClickIncrease() {
        var indexPath: IndexPath?
        cell.indexPath = IndexPath(row: 0, section: 0)
        cell.addHandler = { idxPath in
            indexPath = idxPath
        }
        cell.onClickIncrease(UIButton())

        XCTAssertEqual(indexPath, IndexPath(row: 0, section: 0), "Add handler should be called with correct index path")
    }


}
