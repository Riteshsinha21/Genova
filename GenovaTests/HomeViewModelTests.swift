//
//  HomeViewModelTests.swift
//  GenovaTests
//
//  Created by CTS on 09/04/24.
//

import XCTest
@testable import Genova

final class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!

    override func setUpWithError() throws {
        viewModel = HomeViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testFetchYouMayLikeData() throws {
        // Given
        let expectation = expectation(description: "Fetch You May Like Data")
        
        // When
        viewModel.fetchYouMayLikeData {
            // Then
            XCTAssertTrue(!self.viewModel.youMaylikeCatArr.isEmpty, "You May Like data should not be empty")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

}
