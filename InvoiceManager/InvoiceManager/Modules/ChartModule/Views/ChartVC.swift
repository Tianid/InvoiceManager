//
//  ChartVC.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit
import Charts

class ChartVC: UIViewController {
    //MARK: - Properties
    var presenter: IChartPresenter?
    var pieChart: PieChartView!
    
    var categoryDataEntry1 = PieChartDataEntry(value: 0)
    var categoryDataEntry2 = PieChartDataEntry(value: 0)
    
    var numberOfDataEntries: [PieChartDataEntry] = []
    
    //MARK: - Init
    //MARK: - Func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        configureView()
        configureChart()
    }
    
    private func configureView() {
        pieChart = PieChartView()
        view.addSubview(pieChart)
        pieChart.backgroundColor = .red
        pieChart.drawHoleEnabled = false
        
        pieChart.anchor(
                        size: CGSize(width: 300, height: 300),
                        centerX: view.centerXAnchor,
                        centerY: view.centerYAnchor)
    }
    
    private func configureChart() {
        pieChart.chartDescription?.text = nil
        pieChart.rotationEnabled = false
        
        categoryDataEntry1.value = Double(testCategorys.count)
        categoryDataEntry1.label = "Categorys"
        
        categoryDataEntry2.value = Double(testBills1.count)
        categoryDataEntry2.label = "Bills1"
        
        numberOfDataEntries = [categoryDataEntry1, categoryDataEntry2]
        
        updateChartData()
    }
    
    private func updateChartData() {
        let chartDataSet = PieChartDataSet(entries: numberOfDataEntries)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor.orange, UIColor.blue]
        chartDataSet.colors = colors
        
        pieChart.data = chartData
    }
}

extension ChartVC: IChartVC {
    
}
