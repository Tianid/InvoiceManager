//
//  IPChartViewCell.swift
//  InvoiceManager
//
//  Created by Tianid on 12.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit
import Charts

protocol IPChartViewCell {
    var model: Invoice { get set }
    func prepareLineChartDataSet(filter: ChartsFilter) -> [LineChartDataSet]
    func prepareBarChartDataSet(filter: ChartsFilter) -> [BarChartDataSet]
    func preparePieChartDataSet(filter: ChartsFilter) -> PieChartDataSet
    func getInvoicePrefix() -> String

}
