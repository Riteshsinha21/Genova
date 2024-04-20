//
//  CheckoutVCTests.swift
//  GenovaTests
//
//  Created by CTS on 09/04/24.
//

import XCTest
@testable import Genova

class CheckoutVCTests: XCTestCase {

    var sut: CheckoutVC!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "CheckoutVC") as? CheckoutVC
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testProdCollViewNotNil() {
        XCTAssertNotNil(sut.prodCollView, "prodCollView should not be nil")
    }

    func testProdCollViewRegistersCell() {
        let cell = sut.prodCollView.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: IndexPath(item: 0, section: 0))
        XCTAssertNotNil(cell, "Cell should be dequeued successfully")
    }

    func testNumberOfItemsInSection() {
        let itemCount = sut.collectionView(sut.prodCollView, numberOfItemsInSection: 0)
        XCTAssertEqual(itemCount, SharedData.shared.dummyCartDataArray.count, "Number of items should match dummyCartDataArray count")
    }

    func testCellForItemAtIndexPath() {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = sut.collectionView(sut.prodCollView, cellForItemAt: indexPath)
        XCTAssertNotNil(cell as? ProductListCell, "Cell should be of type ProductListCell")
    }
}
