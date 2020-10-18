//
//  SettingsVCTest.swift
//  InvoiceManagerTests
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import XCTest
@testable import InvoiceManager

class MockTabBar: UITabBarController, ITabBarVC {
    func configureTabBar(router: IRouter) {
        
    }
}

class SettingsVCTest: XCTestCase {
    
    var assembly: AssemblerModuleBuilder!
    var router: IRouter!
    
    override func setUpWithError() throws {
        let delegate = UIApplication.shared.delegate as! AppDelegate
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
    
    func testSettingsVC() {
        let view = assembly.createSettingsModule(router: router) as! SettingsVC
        view.loadView()
        view.viewDidLoad()
        XCTAssertNotNil(view)
        XCTAssertNoThrow(view.presentVC(view: UIViewController()))
        XCTAssertNoThrow(view.showDocumentPicker())
    }
    
    func testSettingsPresenter() {
        let view = SettingsVC()
        let presenter = SettingsPresenter(view: view, router: router, model: testSettings)
        
        XCTAssertNoThrow(presenter.prepareTableViewCell(cell: UITableViewCell(), indexPath: IndexPath(row: 0, section: 0)))
        XCTAssertNoThrow(presenter.cryptedItemSelected(data: Data()))
        XCTAssertNoThrow(presenter.selectedItemAt(indexPath: IndexPath(row: 0, section: 0)))
        XCTAssertNoThrow(presenter.selectedItemAt(indexPath: IndexPath(row: 1, section: 0)))
        XCTAssertNoThrow(presenter.selectedItemAt(indexPath: IndexPath(row: 2, section: 0)))
        XCTAssertNoThrow(presenter.selectedItemAt(indexPath: IndexPath(row: 3, section: 0)))
    }
    
    
    
}
