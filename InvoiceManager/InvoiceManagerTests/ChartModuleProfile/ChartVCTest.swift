//
//  ChartVCTest.swift
//  InvoiceManagerTests
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import XCTest
@testable import InvoiceManager

class ChartVCTest: XCTestCase {
    
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
    
    func testChartVC() {
        let view = ChartVC()
//        let view = assembly.createChartModule(router: router)
        view.viewDidLoad()
        XCTAssertNotNil(view)
    }
    
    func testChartPresenter() {
        let view = ChartVC()
        let presenter = ChartPresenter(view: view, router: router, coreDataManager: CoreDataManagerMock())
        presenter.model = testInvoices
        XCTAssertNoThrow(presenter.prepareCollectionViewCell(cell: ChartViewCell(), index: 0))
        XCTAssertNoThrow(presenter.refreshChartData(complition: nil))
        XCTAssertNoThrow(presenter.refreshChartData(isUseBackground: true, complition: nil))
    }
    
    func testChartView() {
        let view = ChartVC()
        let presenter = ChartPresenter(view: view, router: router, coreDataManager: CoreDataManagerMock())
        let chartView = ChartView()
        chartView.presenter = presenter
        
        XCTAssertNoThrow(chartView.segmentChanged(filter: ChartsFilter.Day))
    }
    
    func testPChartViewCell() {
        let presenter = PChartViewCell(model: testInvoices[0])
        XCTAssertNoThrow(presenter.getInvoicePrefix())
        XCTAssertNoThrow(presenter.prepareBarChartDataSet(filter: ChartsFilter.Day))
        XCTAssertNoThrow(presenter.preparePieChartDataSet(filter: ChartsFilter.Day))
        XCTAssertNoThrow(presenter.prepareLineChartDataSet(filter: ChartsFilter.Day))
    }
    
    func testChartViewCell() {
        let cell = ChartViewCell()

        cell.updateCharts(filter: ChartsFilter.Day)
    }
    
}
