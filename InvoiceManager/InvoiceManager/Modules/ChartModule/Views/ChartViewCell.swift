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
    private var shadowOffsetWidth: Int = 1
    private var shadowOffsetHeight: Int = 1
    private var shadowColor: UIColor? = .black
    private var shadowOpacity: Float = 0.2
    
    var presenter: IPChartViewCell?
        
    var invoiceNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    var curentDataLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "curentDataLabel"
        return label
    }()
    
    var curentBalanceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "curentBalanceLabel"
        return label
    }()
    
    private var invoiceInfoContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        return view
    }()

    private var pieChart: PieChartView = {
        let view = PieChartView()
        return view
    }()
    
    private var lineChart: LineChartView = {
       let view = LineChartView()
        return view
    }()
    
    private var barChart: HorizontalBarChartView = {
        let view = HorizontalBarChartView()
        return view
    }()
    
    private var lineChartContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        return view
    }()
    
    private var barChartContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        return view
    }()
    
    private var lineChartLabel: UILabel = {
        let label = UILabel()
        label.text = "Income and expense graph"
        return label
    }()
    
    private var barChartLabel: UILabel = {
        let label = UILabel()
        label.text = "Number of bills in category graph"
        return label
    }()
    
    //MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureConstraints()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Func

    private func configureConstraints() {
        addSubview(invoiceInfoContainer)
        addSubview(lineChartContainerView)
        addSubview(barChartContainerView)
        
        invoiceInfoContainer.addSubview(invoiceNameLabel)
        invoiceInfoContainer.addSubview(curentDataLabel)
        invoiceInfoContainer.addSubview(curentBalanceLabel)
        
        lineChartContainerView.addSubview(lineChart)
        lineChartContainerView.addSubview(lineChartLabel)
//        barChartContainerView.addSubview(barChart)
        barChartContainerView.addSubview(pieChart)
        barChartContainerView.addSubview(barChartLabel)
        
        //MARK: -
        invoiceInfoContainer.anchor(top: safeAreaLayoutGuide.topAnchor,
                                    leading: safeAreaLayoutGuide.leadingAnchor,
                                    trailing: safeAreaLayoutGuide.trailingAnchor,
                                    padding: UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 5))
        
        invoiceNameLabel.anchor(top: invoiceInfoContainer.topAnchor,
                                leading: invoiceInfoContainer.leadingAnchor,
                                trailing: invoiceInfoContainer.trailingAnchor)
        
        curentDataLabel.anchor(top: invoiceNameLabel.bottomAnchor,
                               leading: invoiceNameLabel.leadingAnchor,
                               trailing: invoiceNameLabel.trailingAnchor)
        
        curentBalanceLabel.anchor(top: curentDataLabel.bottomAnchor,
                                  leading: curentDataLabel.leadingAnchor,
                                  bottom: invoiceInfoContainer.bottomAnchor,
                                  trailing: curentDataLabel.trailingAnchor)
        
        //MARK: -
        lineChartContainerView.anchor(top: invoiceInfoContainer.bottomAnchor,
                                      leading: invoiceInfoContainer.leadingAnchor,
                                      trailing: invoiceInfoContainer.trailingAnchor,
                                      padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0),
                                      size: CGSize(width: 0, height: 200))
        
        barChartContainerView.anchor(top: lineChartContainerView.bottomAnchor,
                                     leading: lineChartContainerView.leadingAnchor,
                                     bottom: safeAreaLayoutGuide.bottomAnchor,
                                     trailing: lineChartContainerView.trailingAnchor,
                                     padding: UIEdgeInsets(top: 10, left: 0, bottom: 5, right: 0))
        
        //MARK: -
        
        lineChartLabel.anchor(top: lineChartContainerView.topAnchor,
                              leading: lineChartContainerView.leadingAnchor,
                              trailing: lineChartContainerView.trailingAnchor,
                              padding: UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 0))
        
        lineChart.anchor(top: lineChartLabel.bottomAnchor,
                         leading: lineChartContainerView.leadingAnchor,
                         bottom: lineChartContainerView.bottomAnchor,
                         trailing: lineChartContainerView.trailingAnchor,
                         padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
        
        //MARK: -
        
        barChartLabel.anchor(top: barChartContainerView.topAnchor,
                              leading: barChartContainerView.leadingAnchor,
                              trailing: barChartContainerView.trailingAnchor,
                              padding: UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 0))
        
        
//        barChart.anchor(top: barChartLabel.bottomAnchor,
//                        leading: barChartContainerView.leadingAnchor,
//                        bottom: barChartContainerView.bottomAnchor,
//                        trailing: barChartContainerView.trailingAnchor,
//                        padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
        
        pieChart.anchor(top: barChartLabel.bottomAnchor,
                        leading: barChartContainerView.leadingAnchor,
                        bottom: barChartContainerView.bottomAnchor,
                        trailing: barChartContainerView.trailingAnchor,
                        padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
        
    }
    
    private func configureLineChart(filter: ChartsFilter) {
        guard let lines = presenter?.prepareLineChartDataSet(filter: filter) else { return }
        let data = LineChartData()
        lines.forEach { data.addDataSet($0) }
        
        let formatter = getPrefixFormatter()
        
        lineChart.rightAxis.enabled = false
        lineChart.xAxis.enabled = false
        lineChart.dragEnabled = false
        lineChart.isUserInteractionEnabled = false
        lineChart.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
//        lineChart.leftAxis.setLabelCount(5, force: false)
        lineChart.data = data
        lineChart.animate(xAxisDuration: 0.5)
    }
    
    private func configureBarChart(filter: ChartsFilter) {
        guard let bars = presenter?.prepareBarChartDataSet(filter: filter) else { return }
        let data = BarChartData()
        bars.forEach { data.addDataSet($0)}
        
        barChart.rightAxis.enabled = false
        
        barChart.xAxis.enabled = false
        barChart.dragEnabled = false
        barChart.isUserInteractionEnabled = false
        barChart.leftAxis.setLabelCount(1, force: false)
        barChart.data = data
        barChart.animate(yAxisDuration: 0.5)
    }
    
    private func configurePieChart(filter: ChartsFilter) {
        guard let piece = presenter?.preparePieChartDataSet(filter: filter) else { return }
        let data = PieChartData(dataSet: piece)
        
        piece.valueFont = UIFont.systemFont(ofSize: 10)
        piece.entryLabelFont = UIFont.systemFont(ofSize: 10)
        piece.valueTextColor = .black
        piece.valueFormatter = DefaultValueFormatter(decimals: 0)
        piece.sliceSpace = 1
//        piece.xValuePosition = .outsideSlice
//        piece.yValuePosition = .outsideSlice
        
        let l = pieChart.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.xEntrySpace = 10
        l.yEntrySpace = 0
        
        pieChart.entryLabelFont = UIFont.systemFont(ofSize: 10)
        pieChart.entryLabelColor = .black
        pieChart.isUserInteractionEnabled = false
        pieChart.drawEntryLabelsEnabled = false
        pieChart.data = data
        pieChart.notifyDataSetChanged()
        pieChart.animate(yAxisDuration: 0.5)
        
    }
    
    private func getPrefixFormatter() -> NumberFormatter {
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumFractionDigits = 0
        leftAxisFormatter.maximumFractionDigits = 1
        leftAxisFormatter.negativeSuffix = " \(presenter?.getInvoicePrefix() ?? "")"
        leftAxisFormatter.positiveSuffix = " \(presenter?.getInvoicePrefix() ?? "")"
        return leftAxisFormatter
    }
    
    private func configureViews() {
        setShadowFor(view: invoiceInfoContainer)
        setShadowFor(view: lineChartContainerView)
        setShadowFor(view: barChartContainerView)
    }
    
    private func setShadowFor(view: UIView) {
        view.layer.shadowColor = shadowColor?.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
//        view.layer.shadowPath = shadowPath.cgPath
    }
    
    func updateCharts(filter: ChartsFilter) {
        configureLineChart(filter: filter)
//        configureBarChart(filter: filter)
        configurePieChart(filter: filter)
    }
}
