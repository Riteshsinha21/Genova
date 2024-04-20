//
//  UIViewExtensionTests.swift
//  GenovaTests
//
//  Created by CTS on 09/04/24.
//

import XCTest
@testable import Genova

class UIViewExtensionTests: XCTestCase {
    
    var testView: UIView!
    
    override func setUp() {
        super.setUp()
        testView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    }
    
    override func tearDown() {
        testView = nil
        super.tearDown()
    }
    
    func testShowToast() {
        let message = "Test message"
        testView.showToast(message: message)
        
        // Check if toastLabel is added as a subview
        XCTAssertTrue(testView.subviews.contains(where: { $0 is UILabel }), "Toast label should be added as a subview")
        
        // Check if toastLabel properties are set correctly
        if let toastLabel = testView.subviews.first(where: { $0 is UILabel }) as? UILabel {
            XCTAssertEqual(toastLabel.textColor, UIColor.white, "Text color should be white")
            XCTAssertEqual(toastLabel.font, UIFont.systemFont(ofSize: 12.0), "Font should be system font with size 12.0")
            XCTAssertEqual(toastLabel.textAlignment, .center, "Text alignment should be center")
            XCTAssertEqual(toastLabel.backgroundColor, UIColor.black.withAlphaComponent(0.9), "Background color should be black with alpha 0.6")
            XCTAssertEqual(toastLabel.text, message, "Text should be set to the message parameter")
            XCTAssertEqual(toastLabel.layer.cornerRadius, 10, "Corner radius should be 10")
            XCTAssertTrue(toastLabel.clipsToBounds, "Clips to bounds should be true")
            
            // Check if toastLabel frame is set correctly
            let expectedWidth = toastLabel.intrinsicContentSize.width + 20
            let expectedHeight: CGFloat = 35
            let expectedX = testView.frame.size.width / 2 - expectedWidth / 2
            let expectedY = testView.frame.size.height - expectedHeight - 20
            XCTAssertEqual(toastLabel.frame, CGRect(x: expectedX, y: expectedY, width: expectedWidth, height: expectedHeight), "Toast label frame should be set correctly")
        } else {
            XCTFail("Toast label should be added as a subview")
        }
    }
}

