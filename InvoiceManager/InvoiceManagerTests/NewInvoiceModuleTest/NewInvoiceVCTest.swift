//
//  NewInvoiceVCTest.swift
//  InvoiceManagerTests
//
//  Created by Tianid on 03.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import XCTest
@testable import InvoiceManager

class NewInvoiceVCTest: XCTestCase {
    var assembly: AssemblerModuleBuilder!
    var router: IRouter!
    var transition: PanelTransition! = PanelTransition()
    var coreDataManager: ICoreDataManager!

    override func setUpWithError() throws {
        coreDataManager = CoreDataManagerMock()
        let delegate = UIApplication.shared.delegate as! AppDelegate
        assembly = AssemblerModuleBuilder(context: delegate.context)
        router = Router(tabBar: MockTabBar(), assembler: assembly)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        assembly = nil
        router = nil
        transition = nil
        coreDataManager = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNewInvoiceVC()  {
        let view = assembly.createNewInvoiceModule(router: router, superPresenter: nil)
        view.viewDidLoad()
        view.viewWillAppear(false)
        XCTAssertNotNil(view)
    }
    
    func testNewInvoiceView() {
        let view = NewInvoiceView()
        XCTAssertNoThrow(view.getUIData())
    }
    
    func testNewInvoicePresenter() {
        let view = assembly.createNewInvoiceModule(router: router, superPresenter: nil)
        let pres = NewInvoicePresenter(view: view as! INewInvoiceVC, router: router, superPresenter: nil, coreDataManager: coreDataManager)
        pres.saveNewInvoice(data: ("foo", .BYN, nil))
    }
    
    func testNewInvoiceCollectionViewCell() {
        let cell = NewInvoiceCollectionViewCell()
        XCTAssertNotNil(cell)
    }
    
}
