//
//  ProductListVCTests.swift
//  GenovaTests
//
//  Created by CTS on 09/04/24.
//

import XCTest
@testable import Genova

class ProductListVCTests: XCTestCase {

    var viewController: ProductListVC!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "ProductListVC") as? ProductListVC
        viewController.loadViewIfNeeded()
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }

    func testCreateRightBarButton() {
        let _ = viewController.view // Ensure viewDidLoad is called

        // Simulate adding items to the cart
        let dummyItem = ProductList(id: 1, catType: "1", title: "Test", image: "test.png", originalPrice: "10.0", discountedPrice: "8.0", discount: 20, quantity: 1)
        let cartVM = CartViewModel()
        cartVM.addDummyData(dummyItem)
        viewController.badgeCount = cartVM.getDummyDataArray().count

        // Call the method to create the right bar button
        viewController.createRightBarButton()

        // Check if the badge label text is set correctly
        XCTAssertEqual(viewController.badgeLabel.text, "\(viewController.badgeCount)", "Badge label text should be set to badge count")
    }

    func testNumberOfItemsInSection() {
        ProductCategory(id: 1, title: "")
            // Simulate setting the product categories and product list
            viewController.productVM.productCatArr = [ProductCategory(id: 1, title: "Category 1"), ProductCategory(id: 2, title: "Category 2")]
            viewController.productVM.productListArr = [ProductList(id: 1, catType: "1", title: "Product 1", image: "product1.png", originalPrice: "10.0", discountedPrice: "8.0", discount: 20, quantity: 1)]

            // Test number of items in productCatCollView
            XCTAssertEqual(viewController.collectionView(viewController.productCatCollView, numberOfItemsInSection: 0), 2, "Number of items in productCatCollView should be 2")

            // Test number of items in productListCollView
            XCTAssertEqual(viewController.collectionView(viewController.productListCollView, numberOfItemsInSection: 0), 1, "Number of items in productListCollView should be 1")
        }
}

