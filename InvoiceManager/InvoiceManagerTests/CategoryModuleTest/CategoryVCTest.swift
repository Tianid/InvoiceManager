//
//  CategoryVCTest.swift
//  InvoiceManagerTests
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import XCTest
@testable import InvoiceManager

class CategoryVCTest: XCTestCase {
    
    var assembly: AssemblerModuleBuilder!
    var router: IRouter!
    
    override func setUpWithError() throws {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        assembly = AssemblerModuleBuilder(context: delegate.context)
        router = Router(tabBar: MockTabBar(), assembler: assembly)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        assembly = nil
        router = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCategoryVC() {
        let view = assembly.createCategoryModule(router: router)
        view.loadView()
        view.viewDidLoad()
        view.viewWillAppear(false)
        XCTAssertNotNil(view)
    }
    
    func testCategoryPresenter() {
        let view = assembly.createCategoryModule(router: router)

        let catPres = CategoryPresenter(view: view as! ICategoryVC, router: router, model: [testSuperSection])
        catPres.billTapped(indexPath: IndexPath(row: 0, section: 0), isFiltering: false)
        let nib = UINib(nibName: "\(CategoryTableViewCell.self)", bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        let _ = catPres.prepareTableViewCell(cell: cell as! CategoryTableViewCell, indexPath: IndexPath(row: 0, section: 0), isFiltering: false)
    }
}
