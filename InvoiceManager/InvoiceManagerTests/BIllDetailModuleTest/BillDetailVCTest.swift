//
//  BillDetailVCTest.swift
//  InvoiceManagerTests
//
//  Created by Tianid on 11.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import XCTest
@testable import InvoiceManager

class BillDetailVCTest: XCTestCase {
    
    var assembly: AssemblerModuleBuilder!
    var router: IRouter!
    
    override func setUpWithError() throws {
        
        assembly = AssemblerModuleBuilder()
        router = Router(tabBar: MockTabBar(), assembler: assembly)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        assembly = nil
        router = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDetailVC() {
        let view = assembly.createBillDetailsModule(router: router, superPresenter: nil, model: nil, currency: .RUB)
        XCTAssertNotNil(view)
        
    }
    
    func testBillDetailsPresenter() {
        let view = HomeVC()
        let invoice = InvoiceContainer(model: testInvoices)
        let superPres = HomePresenter(view: view, router: router, model: invoice)
        
        XCTAssertNotNil(superPres.showBillDetail(bill: testBills3[0], billIndex: 0))
        
        testingPresentor(state: .creating)
        testingPresentor(state: .editing, model: testBills3[0], superPresenter: superPres)
    }
    
    fileprivate func testingPresentor(state: BillDetailsCreationState, model: Bill? = nil, superPresenter: IHomePresenter? = nil) {
        let view = BillDetailsVC()
        
        let presenter = BillDetailsPresenter(view: view, router: router, model: model, superPresenter: superPresenter, currency: .RUB)
        presenter.billDetailsCreationState = state
        XCTAssertNotNil(BillDetailsPresenter(view: view, router: router, model: model, superPresenter: superPresenter, currency: .RUB))
        
        XCTAssertNoThrow(presenter.categorySelectedWithData(category: testSingleCategory))
        XCTAssertNoThrow(presenter.saveButtonTapped(name: "foo", value: 123, billState: .income, description: ""))
        XCTAssertNoThrow(presenter.categoryFieldTapped(transition: PanelTransition()))
        
    }
    
    func testBillDetailView() {
        testingBillDetailView()
        testingBillDetailView(model: testBills2[0], superPresenter: nil)
        testingBillDetailView(model: testBills2[1], superPresenter: nil)

    }
    
    fileprivate func testingBillDetailView(model: Bill? = nil, superPresenter: IHomePresenter? = nil) {
        let view = BillDetailsVC()
        
        let presenter = BillDetailsPresenter(view: view, router: router, model: model, superPresenter: superPresenter, currency: .RUB)
        let billDetailView = BillDetailsView()
        billDetailView.presenter = presenter
        XCTAssertNoThrow(view.setCategory(name: "foo"))
        XCTAssertNoThrow(view.showBillCategoryModule(view: UIViewController()))
        XCTAssertNoThrow(view.dismissDetail(complition: nil))
        
        XCTAssertNoThrow(billDetailView.updateDetailFields())
        XCTAssertNoThrow(billDetailView.setCategory(name: "foo"))
        
    }
    
    
    
}
