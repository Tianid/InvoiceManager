//
//  ModelsAndOther.swift
//  InvoiceManagerTests
//
//  Created by Tianid on 03.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import XCTest
@testable import InvoiceManager

class ModelsAndOther: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInvoiceInit(){
        XCTAssertNotNil(Invoice(data: ("Foo", .BYN, "")))
    }

    func testDigitButton() {
        let btn = DigitButton()
        XCTAssertNotNil(btn)
        XCTAssertNoThrow(btn.cahangeColorToDefault())
        XCTAssertNoThrow(btn.changeColortoGray())
    }
    
    func testFormattedString() {
        let testStr = "123,3"
        XCTAssertEqual(testStr.currencyInputFormatting() , "12.33")
    }
    
    func testBillsEquals() {
        XCTAssertEqual(testBills1[0], testBills1[0])
        XCTAssertNotEqual(testBills1[0], testBills1[1])
    }
    
    func testCategoryEquals() {
        XCTAssertEqual(testCategorys[0], testCategorys[0])
        XCTAssertNotEqual(testCategorys[0], testCategorys[1])
    }
    
    func testCATransition() {
        let trans = CATransition()
        XCTAssertNotNil(trans)
        XCTAssertNoThrow(trans.segueFromBottom())
        XCTAssertNoThrow(trans.segueFromTop())
    }
    
    func testCGPointExtensions() {
        let point = CGPoint(x: 0, y: 0)
        XCTAssertNoThrow(point.projectedOffset(decelerationRate: .fast))
        XCTAssertNoThrow(point.projectedOffset(decelerationRate: .fast))
        XCTAssertNoThrow(point + point)
    }
    
    
    func testDimmPresentationController() {
        let dimm = DimmPresentationController(presentedViewController: UIViewController(), presenting: UIViewController())
        XCTAssertNoThrow(dimm.presentationTransitionDidEnd(false))
        XCTAssertNoThrow(dimm.presentationTransitionWillBegin())
        XCTAssertNoThrow(dimm.presentationTransitionDidEnd(false))
        XCTAssertNoThrow(dimm.dismissalTransitionWillBegin())
        XCTAssertNoThrow(dimm.dismissalTransitionDidEnd(false))
    }
    
    func testPresentationController() {
        let pres = PresentationController(presentedViewController: UIViewController(), presenting: UIViewController())
        XCTAssertNoThrow(pres.presentationTransitionWillBegin())
        XCTAssertNoThrow(pres.presentationTransitionDidEnd(false))
    }
    
    func testNavigationControllerExtension() {
        let nav = UINavigationController()
        nav.popViewController(completion: {
            
        })
        nav.popViewControllerTo(controller: UIViewController(), animated: false, completion: nil)
    }
    
    func testDate() {
        XCTAssertNoThrow(Date.today)
        XCTAssertNoThrow(Date.thisMonth)
        XCTAssertNoThrow(Date.thisYear)

    }
    
    func testIMColors() {
        XCTAssertNoThrow(CategoryColors.colors)
        XCTAssertNoThrow(CategoryColors.sortedColors)
    }

}
