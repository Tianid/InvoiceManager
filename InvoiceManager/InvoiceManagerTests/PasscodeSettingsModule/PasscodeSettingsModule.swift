//
//  PasscodeSettingsModule.swift
//  InvoiceManagerTests
//
//  Created by Tianid on 26.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import XCTest
@testable import InvoiceManager

class PasscodeSettingsModule: XCTestCase {
    
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
    
    func testPasscodeSettingsPresenter() {
        let view = PasscodeSettingsVC()
        let presenter = PasscodeSettingsPresenter(router: router, view: view, passcode: "0", type: 0)
        view.presenter = presenter
        
        XCTAssertNoThrow(presenter.isPasscodeSet)
        XCTAssertNoThrow(presenter.forceDismiss())
        XCTAssertNoThrow(presenter.turnOnOffPasscodeButtonPressed(view: UIViewController()))
    }
    
    func testPasscodeSettingsVC() {
        let view = PasscodeSettingsVC()
        XCTAssertNoThrow(view.loadView())
        XCTAssertNoThrow(view.viewDidLoad())
        XCTAssertNoThrow(view.dismissToPasscodeSettings(isPasscodeSet: false))
        XCTAssertNoThrow(view.presentPasscodeSettings(view: UIViewController()))
    }

}
