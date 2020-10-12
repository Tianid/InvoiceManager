//
//  PChartViewCell.swift
//  InvoiceManager
//
//  Created by Tianid on 12.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation
import Charts

class PChartViewCell: IPChartViewCell {
    //MARK: - Properties
    var model: Invoice
    private var barChartDataSets = [BarChartDataSet]()
    
    //MARK: - Lines properties
    private let circleRadius: CGFloat = 3
    private let circleHoleRadius: CGFloat = 1.8
    private let lineWidth: CGFloat = 3
    
    //MARK: - Init
    
    init(model: Invoice) {
        self.model = model
    }
    
    //MARK: - Func

    func getInvoicePrefix() -> String {
        return model.currency.symbolRaw
    }
    
    func prepareLineChartDataSet() -> [LineChartDataSet] {
        var incomeLineChartEntry = [ChartDataEntry]()
        var expenseLineChartEntry = [ChartDataEntry]()
        
        for bill in model.bills {
            if bill.value.sign == .plus {
                let chartData = ChartDataEntry(x: Double(incomeLineChartEntry.count), y: bill.value)
                incomeLineChartEntry.append(chartData)
                
            } else {
                let chartData = ChartDataEntry(x: Double(expenseLineChartEntry.count), y: bill.value * -1)
                expenseLineChartEntry.append(chartData)
            }
            
        }
        
        
        let incomeLine = LineChartDataSet(entries: incomeLineChartEntry, label: "Income")
        let expenseLine = LineChartDataSet(entries: expenseLineChartEntry, label: "Expense")
        incomeLine.colors = [.systemGreen]
        expenseLine.colors = [.systemRed]
        
        incomeLine.mode = .cubicBezier
        incomeLine.lineWidth = lineWidth
        incomeLine.circleRadius = circleRadius
        incomeLine.circleHoleRadius = circleHoleRadius
        incomeLine.circleHoleColor = .systemGreen
        incomeLine.circleColors = [ .darkGray]
        
        expenseLine.mode = .cubicBezier
        expenseLine.lineWidth = lineWidth
        expenseLine.circleRadius = circleRadius
        expenseLine.circleHoleRadius = circleHoleRadius
        expenseLine.circleHoleColor = .systemRed
        expenseLine.circleColors = [.darkGray]
        
        return [incomeLine, expenseLine]
    }
    
    func prepareBarChartDataSet() -> [BarChartDataSet] {
        guard barChartDataSets.count == 0 else { return barChartDataSets }
        var categorysDict = [String: Int]()
        
        for bill in model.bills {
            if categorysDict[bill.category.name] == nil {
                categorysDict[bill.category.name] = 1
            } else {
                categorysDict[bill.category.name]! += 1
            }
        }
        
       
        barChartDataSets = generateBarChartDataSets(categorysDict: categorysDict)
        
        return barChartDataSets
    }
    
    private func generateBarChartDataSets(categorysDict: [String: Int]) -> [BarChartDataSet] {
        var dataSets = [BarChartDataSet]()
        
        let sorted = categorysDict.sorted { $0.key > $1.key }
        var x = 0
        for item in sorted {
            let value = BarChartDataEntry(x: Double(x), y: Double(item.value))
            let set = BarChartDataSet(entries: [value], label: item.key)
            dataSets.append(set)
            x += 1
        }
        
        return dataSets
    }
}

