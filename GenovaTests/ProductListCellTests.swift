//
//  ProductListCellTests.swift
//  GenovaTests
//
//  Created by CTS on 09/04/24.
//

import XCTest
@testable import Genova

class ProductListCellTests: XCTestCase {

    var cell: ProductListCell!

    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: ProductListCell.self)
        let nib = UINib(nibName: "ProductListCell", bundle: bundle)
        let objects = nib.instantiate(withOwner: nil, options: nil)
        if let cell = objects.first as? ProductListCell {
            self.cell = cell
        } else {
            XCTFail("Unable to instantiate ProductListCell from nib")
        }
    }

    override func tearDown() {
        cell = nil
        super.tearDown()
    }

    func testSetProductList() {
        let productList = ProductList(id: 1, catType: "1", title: "Product 1", image: "product1.png", originalPrice: "10.0", discountedPrice: "8.0", discount: 20, quantity: 1)
        cell.productList = productList

        XCTAssertEqual(cell.productTitleLbl.text, "Product 1", "Product title label should be set to 'Product 1'")
        XCTAssertEqual(cell.productCatLbl.text, "1", "Product category label should be set to '1'")
        XCTAssertEqual(cell.productPriceLbl.text, "8.0", "Product price label should be set to '8.0'")
        XCTAssertEqual(cell.prodImg.image, UIImage(named: "product1.png"), "Product image should be set to 'product1.png'")
    }


}
