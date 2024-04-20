//
//  ShadowViewTests.swift
//  GenovaTests
//
//  Created by CTS on 09/04/24.
//

import XCTest
@testable import Genova

class ShadowViewTests: XCTestCase {

    var shadowView: ShadowView!

    override func setUp() {
        super.setUp()
        shadowView = ShadowView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }

    override func tearDown() {
        shadowView = nil
        super.tearDown()
    }

    func testShadowProperties() {
        XCTAssertEqual(shadowView.layer.shadowColor, UIColor(red: 8/255, green: 106/255, blue: 161/255, alpha: 1.0).cgColor, "Shadow color should be set correctly")
        XCTAssertEqual(shadowView.layer.shadowOpacity, 0.5, "Shadow opacity should be set correctly")
        XCTAssertEqual(shadowView.layer.shadowOffset, CGSize(width: 0, height: 2), "Shadow offset should be set correctly")
        XCTAssertEqual(shadowView.layer.shadowRadius, 8, "Shadow radius should be set correctly")
        XCTAssertFalse(shadowView.layer.masksToBounds, "Masks to bounds should be false")
    }

}
