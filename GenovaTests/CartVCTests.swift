//
//  CartVCTests.swift
//  GenovaTests
//
//  Created by CTS on 09/04/24.
//

import XCTest
@testable import Genova

class CartVCTests: XCTestCase {

    var viewController: CartVC!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "CartVC") as? CartVC
        viewController.loadViewIfNeeded()
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }

    func testSetTotalPrice() {
        let dummyDataArray: [ProductList] = [
            ProductList(id: 1, catType: "1", title: "Product 1", image: "product1.png", originalPrice: "10.0", discountedPrice: "8.0", discount: 20, quantity: 1),
            ProductList(id: 2, catType: "2", title: "Product 2", image: "product2.png", originalPrice: "20.0", discountedPrice: "16.0", discount: 20, quantity: 2)
        ]
        viewController.dummyCartDataArray = dummyDataArray
        viewController.setTotalPrice()

        XCTAssertEqual(viewController.totalPriceLbl.text, "40.0", "Total price label should be set to '40.0'")
    }

    func testTableViewDataSource() {
        guard let tableView = viewController.cartTableView else {
            XCTFail("Table view is nil")
            return
        }
        
        let dummyDataArray: [ProductList] = [
            ProductList(id: 1, catType: "1", title: "Product 1", image: "product1.png", originalPrice: "10.0", discountedPrice: "8.0", discount: 20, quantity: 1),
            ProductList(id: 2, catType: "2", title: "Product 2", image: "product2.png", originalPrice: "20.0", discountedPrice: "16.0", discount: 20, quantity: 2)
        ]
        viewController.dummyCartDataArray = dummyDataArray
        tableView.reloadData()
        
        XCTAssertEqual(viewController.tableView(tableView, numberOfRowsInSection: 0), 2, "Table view should have 2 rows")
        let cell1 = viewController.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CartCell
        XCTAssertEqual(cell1?.catTitlelbl.text, "Product 1", "First cell's title should be 'Product 1'")
        XCTAssertEqual(cell1?.catTypeLbl.text, "1", "First cell's category should be '1'")
        XCTAssertEqual(cell1?.priceLbl.text, "8.0", "First cell's price should be '8.0'")
        XCTAssertEqual(cell1?.quantityLbl.text, "1", "First cell's quantity should be '1'")
        
        let cell2 = viewController.tableView(tableView, cellForRowAt: IndexPath(row: 1, section: 0)) as? CartCell
        XCTAssertEqual(cell2?.catTitlelbl.text, "Product 2", "Second cell's title should be 'Product 2'")
        XCTAssertEqual(cell2?.catTypeLbl.text, "2", "Second cell's category should be '2'")
        XCTAssertEqual(cell2?.priceLbl.text, "16.0", "Second cell's price should be '16.0'")
        XCTAssertEqual(cell2?.quantityLbl.text, "2", "Second cell's quantity should be '2'")
    }



}
