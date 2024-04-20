//
//  ProductCategoryCellTests.swift
//  GenovaTests
//
//  Created by CTS on 09/04/24.
//

import XCTest
@testable import Genova

class ProductCategoryCellTests: XCTestCase {

    var cell: ProductCategoryCell!

    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: ProductCategoryCell.self)
        let nib = UINib(nibName: "ProductCategoryCell", bundle: bundle)
        let objects = nib.instantiate(withOwner: nil, options: nil)
        guard let cell = objects.first as? ProductCategoryCell else {
            XCTFail("Unable to instantiate ProductCategoryCell from nib")
            return
        }
        self.cell = cell
    }

    override func tearDown() {
        cell = nil
        super.tearDown()
    }

    func testSetProductCat() {
        let productCat = ProductCategory(id: 1, title: "Test Category")
        cell.productCat = productCat

        XCTAssertEqual(cell.catTitle.text, productCat.title, "catTitle should be set to productCat.title")
    }
}
