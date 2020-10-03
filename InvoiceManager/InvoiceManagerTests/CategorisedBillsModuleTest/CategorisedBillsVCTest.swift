//
//  CategorisedBillsVCTest.swift
//  InvoiceManagerTests
//
//  Created by Tianid on 03.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import XCTest
@testable import InvoiceManager

class CategorisedBillsVCTest: XCTestCase {
    var assembly: AssemblerModuleBuilder!
    var router: IRouter!
    var transition: PanelTransition! = PanelTransition()
    
    override func setUpWithError() throws {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        assembly = AssemblerModuleBuilder(context: delegate.context)
        router = Router(tabBar: MockTabBar(), assembler: assembly)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        assembly = nil
        router = nil
        transition = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCategorisedBillsVC()  {
        let view = assembly.createCategorisedBillsModule(router: router, category: testCategorys[0])
        view.viewDidLoad()
        view.viewWillAppear(false)
        XCTAssertNotNil(view)
    }
    
    func testCategorisedBillsView() {
        let view = assembly.createCategorisedBillsModule(router: router, category: testCategorys[0])
        view.viewDidLoad()
        view.viewWillAppear(false)
        let categorisedView = CategorisedBillsView()
        categorisedView.presenter = CategorisedBillsPresenter(view: view as! ICategorisedBillsVC, router: router, model: testInvoices)
        categorisedView.presenter?.model.append(testInvoices[0])
        
    }
    
    func testCategorisedBillsPresenter() {
        let view = assembly.createCategorisedBillsModule(router: router, category: testCategorys[0])

        let catPres = CategorisedBillsPresenter(view: view as! ICategorisedBillsVC, router: router, model: testInvoices)
        catPres.billTapped(indexPath: IndexPath(row: 0, section: 0))
        let nib = UINib(nibName: "\(HomeViewTableViewCell.self)", bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        XCTAssertNotNil(catPres.prepareTableViewCell(cell: cell as! HomeViewTableViewCell, indexPath: IndexPath(row: 0, section: 0)))
    }
    
    func testCategorisedBillsTableViewCell() {
        let nib = UINib(nibName: "\(CategorisedBillsTableViewCell.self)", bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        XCTAssertNotNil(cell)
    }
    
    
}
