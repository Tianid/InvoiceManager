//
//  HomeVCTest.swift
//  InvoiceManagerTests
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import XCTest
@testable import InvoiceManager

class HomeVCTest: XCTestCase {
    
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
    
    func testHomeVC() {
        let view = assembly.createHomeModule(router: router)
        XCTAssertNotNil(view)
    }
    
    func testHomePresenter() {
        let view = HomeVC()
        let invoiceContainer = InvoiceContainer(model: testInvoices)
        let presenter = HomePresenter(view: view, router: router, model: invoiceContainer)
        
        XCTAssertNoThrow(presenter.setInvoiceInex(invoiceIndex: 0), "work fine")
        XCTAssertNoThrow(presenter.transferNewBill(bill: testBills3[0], billDetailsCreationState: .creating))
        //        XCTAssertNoThrow(presenter.transferNewBill(bill: testBills3[0], billDetailsCreationState: .editing))
        XCTAssertNoThrow(presenter.showBillDetail(bill: nil, billIndex: nil))
    }
    
    func testSPHomeView() {
        let view = HomeVC()
        let invoiceContainer = InvoiceContainer(model: testInvoices)
        let presenter = HomePresenter(view: view, router: router, model: invoiceContainer)
        
        let homeView = HomeView()
        
        
        let spHomeView = SPHomeView(superPresenter: presenter, model: invoiceContainer, view: homeView)
        XCTAssertNoThrow(spHomeView.setInvoiceIndex(invoiceIndex: 0))
        XCTAssertNoThrow(spHomeView.generateSPHomeViewCell(index: 0))
        XCTAssertNoThrow(spHomeView.showBillDetail(bill: nil, billIndex: nil))
        XCTAssertNoThrow(spHomeView.showBillDetail(bill: testBills3[0], billIndex: 0))
        XCTAssertNoThrow(spHomeView.showBillDetail(bill: testBills3[0], billIndex: nil))
        XCTAssertNoThrow(spHomeView.showBillDetail(bill: nil, billIndex: 0))
    }
    
    func testSPHomveViewCell() {
        let view = HomeVC()
        let invoiceContainer = InvoiceContainer(model: testInvoices)
        let presenter = HomePresenter(view: view, router: router, model: invoiceContainer)
        
        let homeView = HomeView()
        
        
        let spHomeView = SPHomeView(superPresenter: presenter, model: invoiceContainer, view: homeView)
        let spHomeViewCell = SPHomeViewCell(superPresenter: spHomeView, invoiceIndex: 0)
        XCTAssertNoThrow(SPHomeViewCell(superPresenter: spHomeView, invoiceIndex: 0))
        XCTAssertNoThrow(spHomeViewCell.setInvoiceInex(invoiceIndex: 0))
        XCTAssertNoThrow(spHomeViewCell.billTapped(billIndex: 0))
        XCTAssertNoThrow(spHomeViewCell.model = testBills3)
        
    }
    
    func testHomeCollectionViewCell() {
        let cell = HomeViewCollectionViewCell()
        let view = HomeVC()
        let invoiceContainer = InvoiceContainer(model: testInvoices)
        let presenter = HomePresenter(view: view, router: router, model: invoiceContainer)
        
        let homeView = HomeView()
        
        
        let spHomeView = SPHomeView(superPresenter: presenter, model: invoiceContainer, view: homeView)
        
        cell.presenter = SPHomeViewCell(superPresenter: spHomeView, invoiceIndex: 0)
        XCTAssertNoThrow(cell.insertNewRow())
        XCTAssertNoThrow(cell.refreshTableViewByBillIndex(billIndex: 0))
    }
}
