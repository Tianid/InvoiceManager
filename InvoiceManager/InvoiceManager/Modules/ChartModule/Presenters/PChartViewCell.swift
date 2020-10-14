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
//    private var barChartDataSets = [BarChartDataSet]()
//    private var pieChartDataSets: PieChartDataSet!
    private let limitOfPieChartData = 20
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
    
    func prepareLineChartDataSet(filter: ChartsFilter) -> [LineChartDataSet] {
        var incomeLineChartEntry = [ChartDataEntry]()
        var expenseLineChartEntry = [ChartDataEntry]()
        let preparedModels: [Bill] = prepareChartModels(filter: filter)
        
        for bill in preparedModels {
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
    
    func prepareBarChartDataSet(filter: ChartsFilter) -> [BarChartDataSet] {
        
        var categorysDict = [String: Int]()
        let preparedModels: [Bill] = prepareChartModels(filter: filter)

        for bill in preparedModels {
            if categorysDict[bill.category.name] == nil {
                categorysDict[bill.category.name] = 1
            } else {
                categorysDict[bill.category.name]! += 1
            }
        }
       
        let barChartDataSets = generateBarChartDataSets(categorysDict: categorysDict)
        
        return barChartDataSets
    }
    
    func preparePieChartDataSet(filter: ChartsFilter) -> PieChartDataSet {
        
        var categorysDict = [String: Int]()
        let preparedModels: [Bill] = prepareChartModels(filter: filter)

        for bill in preparedModels {
            if categorysDict[bill.category.name] == nil {
                categorysDict[bill.category.name] = 1
            } else {
                categorysDict[bill.category.name]! += 1
            }
        }
       
        let pieChartDataSets = generatePieChartDataSets(categorysDict: categorysDict)
        
        return pieChartDataSets
    }
    
    private func generateBarChartDataSets(categorysDict: [String: Int]) -> [BarChartDataSet] {
        var dataSets = [BarChartDataSet]()
        
        let sorted = categorysDict.sorted { $0.value > $1.value }
        var x = 0
        for item in sorted {
            let value = BarChartDataEntry(x: Double(x), y: Double(item.value), data: item.value)
            let set = BarChartDataSet(entries: [value], label: item.key)
            set.colors.removeAll()
            set.colors.append(CategoryColors.colors[item.key]!)
            dataSets.append(set)
            x += 1
        }
        
        return dataSets
    }
    
    private func generatePieChartDataSets(categorysDict: [String: Int]) -> PieChartDataSet {
        var values: [PieChartDataEntry] = []
        
        let sorted = categorysDict.sorted { $0.value < $1.value }
        for (index, item) in sorted.enumerated() {
            guard index <= limitOfPieChartData else { break }
            let value = PieChartDataEntry(value: Double(item.value), label: item.key)
            value.label = item.key
            values.append(value)
        }
        
        let pieSet = PieChartDataSet(entries: values, label: nil)
        pieSet.colors.removeAll()
        values.forEach {
            pieSet.colors.append(CategoryColors.colors[$0.label!]!)
        }
        return pieSet
    }
    
    private func prepareChartModels(filter: ChartsFilter) -> [Bill] {
        switch filter {
        case .Day:
            return model.bills.filter {
                let today = Date.today
                return $0.creationDate >= today.start && $0.creationDate <= today.end
            }
        case .Month:
            return model.bills.filter {
                  let today = Date.thisMonth
                return $0.creationDate >= today.start && $0.creationDate <= today.end
              }
        case .Year:
            return model.bills.filter {
                  let today = Date.thisYear
                  return $0.creationDate >= today.start && $0.creationDate <= today.end
              }
        case .Alltime:
            return model.bills
        }
    }
}

