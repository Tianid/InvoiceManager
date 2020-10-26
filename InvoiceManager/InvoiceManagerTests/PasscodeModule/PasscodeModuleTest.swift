//
//  PasscodeModuleTest.swift
//  InvoiceManagerTests
//
//  Created by Tianid on 26.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import XCTest
@testable import InvoiceManager

class PasscodeModuleTest: XCTestCase {

    var assembly: AssemblerModuleBuilder!
    var router: IRouter!
    
    override func setUpWithError() throws {
        
        let coreDataManagerMock = CoreDataManagerMock()
        assembly = AssemblerModuleBuilder(coreDataManager: coreDataManagerMock)
        router = Router(tabBar: MockTabBar(), assembler: assembly)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        assembly = nil
        router = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPasscodeVC() {
        let view = PasscodeVC()
        XCTAssertNoThrow(view.presentViewController(view: UIViewController()))
        XCTAssertNoThrow(view.dismissPasscode(animated: false))
        XCTAssertNoThrow(view.dismissPasscodeScreen(animated: false))
    }
    
    func testPasscodePresenter() {
        let view = PasscodeVC()
        let presenter = PasscodePresenter(router: router, view: view, type: 0, passcode: "0")
        view.presenter = presenter
        
        XCTAssertNoThrow(presenter.didCancelTapped())
        XCTAssertNoThrow(presenter.didEnterCorrectCode())
        XCTAssertNoThrow(presenter.enterPasscodeButtonTapped(view: UIViewController()))
    }
}
