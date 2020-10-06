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
    var coreDataManager: ICoreDataManager!
    
    override func setUpWithError() throws {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        coreDataManager = CoreDataManagerMock()
        assembly = AssemblerModuleBuilder(context: delegate.context)
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
        let presenter = HomePresenter(view: view, router: router, model: invoiceContainer, coreDataManager: coreDataManager)
        
        XCTAssertNoThrow(presenter.setInvoiceIndex(invoiceIndex: 0), "work fine")
        XCTAssertNoThrow(presenter.showBillDetail(billIndex: 0))

        XCTAssertNoThrow(presenter.presentBillIntoUI(bill: testBills3[0], billDetailsCreationState: .creating))
        XCTAssertNoThrow(presenter.presentBillIntoUI(bill: testBills3[0], billDetailsCreationState: .editing))
        XCTAssertNoThrow(presenter.addNewInvoice(invoice: testInvoices[0]))
        XCTAssertNoThrow(presenter.setInvoiceIndex(invoiceIndex: 0))
        XCTAssertNoThrow(presenter.updateInvoiceName(name: "foo", complition: nil))
        XCTAssertNoThrow(presenter.deleteBillInModel(bill: testBills1[0], indexPath: IndexPath(row: 0, section: 0)))
        XCTAssertNoThrow(presenter.deleteInvoice(complition: nil))
        XCTAssertNoThrow(presenter.showNewInvoice())
        XCTAssertNoThrow(presenter.presentAlert(alert: UIAlertController(title: nil, message: nil, preferredStyle: .alert)))
    }
    
    func testHomeView() {
        let view = HomeVC()
        let invoiceContainer = InvoiceContainer(model: testInvoices)
        let presenter = HomePresenter(view: view, router: router, model: invoiceContainer, coreDataManager: coreDataManager)
        
        let homeView = HomeView()
        
        homeView.presenter = presenter
        
        presenter.presentBillIntoUI(bill: testBills1[0], billDetailsCreationState: .creating)
        XCTAssertNoThrow(homeView.insertNewBill(index: 0))

        XCTAssertNoThrow(homeView.insertNewDataInTable(index: 0))
        XCTAssertNoThrow(homeView.insertNewInvoice())
        XCTAssertNoThrow(homeView.deleteRowInTableView(invoiceIndex: 0, billIndex: 0))
        XCTAssertNoThrow(homeView.refreshTableViewByIndex(invoiceIndex: 0, billIndex: 0))
        XCTAssertNoThrow(homeView.viewWillTransition())
    }
    
    func testSPHomveViewCell() {
        let view = HomeVC()
        let invoiceContainer = InvoiceContainer(model: testInvoices)
        let presenter = HomePresenter(view: view, router: router, model: invoiceContainer, coreDataManager: coreDataManager)
        
        let cellPresenter = PHomeCollectionViewCell(invoice: testInvoices[0], superPresenter: presenter)
        XCTAssertNoThrow(cellPresenter.billTapped(billIndex: 0))
        XCTAssertNoThrow(cellPresenter.reloadBills())
    }
    
    func testHomeCollectionViewCell() {
        let cell = HomeViewCollectionViewCell()
        let view = HomeVC()
        let invoiceContainer = InvoiceContainer(model: testInvoices)
        let presenter = HomePresenter(view: view, router: router, model: invoiceContainer, coreDataManager: coreDataManager)
        
        
        let cellPresenter = PHomeCollectionViewCell(invoice: testInvoices[0], superPresenter: presenter)
        cell.presenter = cellPresenter
        presenter.presentBillIntoUI(bill: testBills1[0], billDetailsCreationState: .creating)
        XCTAssertNoThrow(cell.insertNewRow())
        XCTAssertNoThrow(presenter.showBillDetail(billIndex: 0))
        XCTAssertNoThrow(presenter.deleteBillInModel(bill: testBills1[0], indexPath: IndexPath(row: 0, section: 0)))
        XCTAssertNoThrow(cell.deleteRowInTableView(billIndex: 0))
        XCTAssertNoThrow(cell.refreshTableViewByBillIndex(billIndex: 0))

    }
}
