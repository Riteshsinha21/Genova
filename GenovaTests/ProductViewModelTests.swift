//
//  ProductViewModelTests.swift
//  GenovaTests
//
//  Created by CTS on 09/04/24.
//

import XCTest
@testable import Genova

class ProductViewModelTests: XCTestCase {
    
    var viewModel: ProductViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ProductViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchProductCategorySuccess() {
        let expectation = self.expectation(description: "Fetch Product Category")
        
        viewModel.fetchProductCategory {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertFalse(viewModel.productCatArr.isEmpty)
    }
    
    
    func testFetchProductListSuccess() {
        let expectation = self.expectation(description: "Fetch Product List")
        
        viewModel.fetchProductList(completion: {
            // This closure should be called on success
            expectation.fulfill()
        }, errorHandler: { error in
            // This closure should not be called on success
            XCTFail("fetchProductList should not call the error handler on success")
        })
        
        waitForExpectations(timeout: 1, handler: nil)
        
        // Assert that productListArr is not empty
        XCTAssertFalse(viewModel.productListArr.isEmpty)
    }


}
