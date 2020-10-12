//
//  ChartViewCell.swift
//  InvoiceManager
//
//  Created by Tianid on 12.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit
import Charts

class ChartViewCell: UICollectionViewCell {
    //MARK: - Properties
    var presenter: IPChartViewCell?
        
    var invoiceNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    private var pieChart: PieChartView!
    
    private var lineChart: LineChartView = {
       let view = LineChartView()
        return view
    }()
    
    private var barChart: HorizontalBarChartView = {
        let view = HorizontalBarChartView()
        return view
    }()
       
    var categoryDataEntry1 = PieChartDataEntry(value: 0)
    var categoryDataEntry2 = PieChartDataEntry(value: 0)
       
    var numberOfDataEntries: [PieChartDataEntry] = []
    //MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Func

    private func configureConstraints() {
        addSubview(invoiceNameLabel)
        addSubview(lineChart)
        addSubview(barChart)
        
        invoiceNameLabel.anchor(top: safeAreaLayoutGuide.topAnchor,
                                leading: safeAreaLayoutGuide.leadingAnchor,
                                trailing: safeAreaLayoutGuide.trailingAnchor,
                                padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
        
        lineChart.anchor(top: invoiceNameLabel.bottomAnchor,
                         leading: invoiceNameLabel.leadingAnchor,
                         trailing: invoiceNameLabel.trailingAnchor,
                         size: CGSize(width: self.frame.width, height: 250))
        
        barChart.anchor(top: lineChart.bottomAnchor, leading: lineChart.leadingAnchor,
                        bottom: safeAreaLayoutGuide.bottomAnchor,
                        trailing: lineChart.trailingAnchor)
        
    }
    
    private func configureLineChart() {
        guard let lines = presenter?.prepareLineChartDataSet() else { return }
        let data = LineChartData()
        lines.forEach { data.addDataSet($0) }
        
        let formatter = gerPrefixFormatter()
        
        lineChart.rightAxis.enabled = false
        lineChart.xAxis.enabled = false
        lineChart.dragEnabled = false
        lineChart.isUserInteractionEnabled = false
        lineChart.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
//        lineChart.leftAxis.setLabelCount(5, force: false)
        lineChart.data = data
    }
    
    private func configureBarChart() {
        guard let bars = presenter?.prepareBarChartDataSet() else { return }
        let data = BarChartData()
        bars.forEach { data.addDataSet($0)}
        
        barChart.rightAxis.enabled = false
        
        barChart.xAxis.enabled = false
        barChart.dragEnabled = false
        barChart.isUserInteractionEnabled = false
        barChart.leftAxis.setLabelCount(1, force: false)
        barChart.data = data
    }
    
    private func gerPrefixFormatter() -> NumberFormatter {
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumFractionDigits = 0
        leftAxisFormatter.maximumFractionDigits = 1
        leftAxisFormatter.negativeSuffix = " \(presenter?.getInvoicePrefix() ?? "")"
        leftAxisFormatter.positiveSuffix = " \(presenter?.getInvoicePrefix() ?? "")"
        return leftAxisFormatter
    }
    
    func updateCharts() {
        configureLineChart()
        configureBarChart()
    }

}
