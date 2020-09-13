//
//  BillCategoryVCTest.swift
//  InvoiceManagerTests
//
//  Created by Tianid on 11.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import XCTest
@testable import InvoiceManager

class BillCategoryVCTest: XCTestCase {

    var assembly: AssemblerModuleBuilder!
    var router: IRouter!
    var transition: PanelTransition! = PanelTransition()
    
    override func setUpWithError() throws {
        
        assembly = AssemblerModuleBuilder()
        router = Router(tabBar: MockTabBar(), assembler: assembly)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        assembly = nil
        router = nil
        transition = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBillCategoryVC() {
        let view = assembly.createBillCategoryModule(router: router, transition: transition, superPresenter: nil) as! BillCategoryVC
        view.viewDidLoad()
        view.dismissBillCategory(complition: nil)
        XCTAssertNotNil(view)
        
    }
    
    func testBillCategoryPresenter() {
        let view = assembly.createBillCategoryModule(router: router, transition: transition, superPresenter: nil)
        
        
        let billCategoryPresenter = BillCategoryPresenter(view: view as! IBillCategoryVC, router: router, model: [testSingleCategory], superPresenter: nil)
        XCTAssertNotNil(billCategoryPresenter)
        XCTAssertNoThrow(billCategoryPresenter.categorySelected(index: 0))
    }

}
