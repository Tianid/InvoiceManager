//
//  TabBarVCTest.swift
//  InvoiceManagerTests
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import XCTest
@testable import InvoiceManager

class TabBarVCTest: XCTestCase {
    var assmebly: AssemblerModuleBuilder!
    var router: IRouter!
    var tabBarVC: ITabBarVC! = TabBarVC()
    
    override func setUpWithError() throws {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        assmebly = AssemblerModuleBuilder(context: delegate.context)
        router = Router(tabBar: tabBarVC, assembler: assmebly)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        assmebly = nil
        router = nil
        tabBarVC = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTabBarVC() {
        router.initiateTabBar()
        guard let views = tabBarVC.viewControllers else { XCTAssertFalse(true); return}
        for vc in views {
            XCTAssertNotNil(vc)
        }
    }
    
}
