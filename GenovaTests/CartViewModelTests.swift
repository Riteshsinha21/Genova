//
//  CartViewModelTests.swift
//  GenovaTests
//
//  Created by CTS on 09/04/24.
//

import XCTest
@testable import Genova

class CartViewModelTests: XCTestCase {

    var viewModel: CartViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = CartViewModel()
        // Add some initial data to the dummyCartDataArray
        viewModel.addDummyData(ProductList(id: 1, catType: "Spray", title: "Denver", image: "screenshot@1", originalPrice: "200", discountedPrice: "100", discount: 50, quantity: 1))
        viewModel.addDummyData(ProductList(id: 2, catType: "Spray", title: "Tommy Hilfiger", image: "screenshot@1", originalPrice: "200", discountedPrice: "150", discount: 25, quantity: 1))
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }

    func testAddDummyData() {
        // Create a new ProductList item to add
        let newItem = ProductList(id: 3, catType: "Spray", title: "Denver", image: "screenshot@1", originalPrice: "200", discountedPrice: "100", discount: 50, quantity: 1)
        // Call the addDummyData method to add the new item
        viewModel.addDummyData(newItem)
        
        // Assert that the new item is added to the array
        XCTAssertTrue(viewModel.getDummyDataArray().contains(where: { $0.id == newItem.id }))
    }

    func testRemoveDummyData() {
        // Add a dummy item to the cart
        let dummyItem = ProductList(id: 4, catType: "Spray", title: "Denver", image: "screenshot@1", originalPrice: "200", discountedPrice: "100", discount: 50, quantity: 1)
        viewModel.addDummyData(dummyItem)
        
        // Remove the dummy item
        viewModel.removeDummyData(dummyItem)
        
        // Check that the item is removed from the cart
        let cartItems = viewModel.getDummyDataArray()
        let itemIndex = cartItems.firstIndex(where: { $0.id == dummyItem.id })
        XCTAssertNil(itemIndex, "Item should be removed from the cart")
    }
//
    func testCalculateTotalPrice() {
        // Create a mock data array
        let mockDataArray: [ProductList] = [
            ProductList(id: 4, catType: "Spray", title: "Denver", image: "screenshot@1", originalPrice: "200", discountedPrice: "100", discount: 50, quantity: 1),
            ProductList(id: 5, catType: "Spray", title: "Denver", image: "screenshot@1", originalPrice: "200", discountedPrice: "100", discount: 50, quantity: 1),
            ProductList(id: 6, catType: "Spray", title: "Denver", image: "screenshot@1", originalPrice: "200", discountedPrice: "100", discount: 50, quantity: 1)
        ]
        
        // Create an instance of CartViewModel
        let viewModel = CartViewModel()
        // Assign the mock data array to sharedData.dummyCartDataArray
        viewModel.sharedData.dummyCartDataArray = mockDataArray
        
        // Call the calculateTotalPrice method
        let totalPrice = viewModel.calculateTotalPrice()
        
        // Calculate the expected total price based on the mock data array
        let expectedTotalPrice = (100.0 * 1) + (100.0 * 1) + (100.0 * 1)
        
        // Assert that the calculated total price matches the expected total price
        XCTAssertEqual(totalPrice, expectedTotalPrice, "Total price calculation is incorrect")
    }

//
    func testCreateDummyJSON() {
        // Given
        let viewModel = CartViewModel()
        
        // When
        let jsonString = viewModel.createDummyJSON()
        
        // Then
        XCTAssertNotNil(jsonString, "JSON string should not be nil")
        
        if let jsonString = jsonString {
            XCTAssertTrue(isValidJSON(jsonString), "JSON string should contain valid JSON data")
        }
    }

    private func isValidJSON(_ json: String) -> Bool {
        if let _ = try? JSONSerialization.jsonObject(with: json.data(using: .utf8)!, options: []) {
            return true
        }
        return false
    }


}
