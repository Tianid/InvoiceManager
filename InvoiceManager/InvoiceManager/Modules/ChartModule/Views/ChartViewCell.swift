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
    
    private let lineGraphLabelConst = "Income and expense graph"
    private let pieGraphLabelConst = "Most common bills number in category graph"
    private let barGraphLabelConst = "All bills number in category graph"
    private let mockConst = "(No data)"
    private let noDataAvailableMessage = "No chart data available"
    private let labelFontSize: CGFloat = 10
    
    var invoiceNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    var curentDataLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    var curentBalanceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private var invoiceInfoContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "CustomColor")
        view.layer.cornerRadius = 6
        return view
    }()
    
    private var lineChart: LineChartView = {
        let view = LineChartView()
        return view
    }()
    
    private var pieChart: PieChartView = {
        let view = PieChartView()
        return view
    }()
    
    private var barChart: BarChartView = {
        let view = BarChartView()
        return view
    }()
    
    private var lineChartContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "CustomColor")
        view.layer.cornerRadius = 6
        return view
    }()
    
    private var pieChartContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "CustomColor")
        view.layer.cornerRadius = 6
        return view
    }()
    
    private var barChartContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "CustomColor")
        view.layer.cornerRadius = 6
        return view
    }()
    
    private var lineChartLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var pieChartLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var barChartLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
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
    
    override func didTransition(from oldLayout: UICollectionViewLayout, to newLayout: UICollectionViewLayout) {
        super.didTransition(from: oldLayout, to: newLayout)
    }
    
    //MARK: - Func
    
    private func configureConstraints() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(invoiceInfoContainer)
        containerView.addSubview(lineChartContainerView)
        containerView.addSubview(pieChartContainerView)
        containerView.addSubview(barChartContainerView)
        
        invoiceInfoContainer.addSubview(invoiceNameLabel)
        invoiceInfoContainer.addSubview(curentDataLabel)
        invoiceInfoContainer.addSubview(curentBalanceLabel)
        
        lineChartContainerView.addSubview(lineChart)
        lineChartContainerView.addSubview(lineChartLabel)
        pieChartContainerView.addSubview(pieChart)
        pieChartContainerView.addSubview(pieChartLabel)
        barChartContainerView.addSubview(barChart)
        barChartContainerView.addSubview(barChartLabel)
        
        
        //MARK: -
        scrollView.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            leading: safeAreaLayoutGuide.leadingAnchor,
            bottom: safeAreaLayoutGuide.bottomAnchor,
            trailing: safeAreaLayoutGuide.trailingAnchor)
        
        containerView.anchor(
            top: scrollView.topAnchor,
            leading: scrollView.leadingAnchor,
            bottom: scrollView.bottomAnchor,
            trailing: scrollView.trailingAnchor)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        //MARK: -
        invoiceInfoContainer.anchor(top: containerView.topAnchor,
                                    leading: containerView.leadingAnchor,
                                    trailing: containerView.trailingAnchor,
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
                                      size: CGSize(width: 0, height: 300))
        
        pieChartContainerView.anchor(top: lineChartContainerView.bottomAnchor,
                                     leading: lineChartContainerView.leadingAnchor,
                                     trailing: lineChartContainerView.trailingAnchor,
                                     padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0),
                                     size: CGSize(width: 0, height: 300))
        
        barChartContainerView.anchor(top: pieChartContainerView.bottomAnchor,
                                     leading: pieChartContainerView.leadingAnchor,
                                     bottom: containerView.bottomAnchor,
                                     trailing: pieChartContainerView.trailingAnchor,
                                     padding: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0),
                                     size: CGSize(width: 0, height: 300))
        
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
        
        pieChartLabel.anchor(top: pieChartContainerView.topAnchor,
                             leading: pieChartContainerView.leadingAnchor,
                             trailing: pieChartContainerView.trailingAnchor,
                             padding: UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 0))
        
        pieChart.anchor(top: pieChartLabel.bottomAnchor,
                        leading: pieChartContainerView.leadingAnchor,
                        bottom: pieChartContainerView.bottomAnchor,
                        trailing: pieChartContainerView.trailingAnchor,
                        padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        //MARK: -
        
        barChartLabel.anchor(top: barChartContainerView.topAnchor,
                             leading: barChartContainerView.leadingAnchor,
                             trailing: barChartContainerView.trailingAnchor,
                             padding: UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 0))
        
        barChart.anchor(top: barChartLabel.bottomAnchor,
                        leading: barChartContainerView.leadingAnchor,
                        bottom: barChartContainerView.bottomAnchor,
                        trailing: barChartContainerView.trailingAnchor,
                        padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
    }
    
    private func configureLineChart(filter: ChartsFilter) {
        guard let lineSets = presenter?.prepareLineChartDataSet(filter: filter), !lineSets[0].entries.isEmpty || !lineSets[1].entries.isEmpty else {
            lineChart.data = nil
            return
        }
        let data = LineChartData()
        
        lineSets.forEach { data.addDataSet($0) }
        let formatter = getPrefixFormatter()
        
        lineChart.rightAxis.enabled = false
        lineChart.xAxis.enabled = false
        lineChart.dragEnabled = false
        lineChart.isUserInteractionEnabled = false
        lineChart.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
        lineChart.noDataText = noDataAvailableMessage
        //        lineChart.leftAxis.setLabelCount(5, force: false)
        lineChart.data = data
        lineChart.animate(xAxisDuration: 0.5)
    }
        
    private func configurePieChart(filter: ChartsFilter) {
        guard let pieSet = presenter?.preparePieChartDataSet(filter: filter), !pieSet.isEmpty else {
            pieChart.data = nil
            return
        }
        let data = PieChartData(dataSet: pieSet)
        
        pieSet.valueFont = UIFont.systemFont(ofSize: 10)
        pieSet.entryLabelFont = UIFont.systemFont(ofSize: 10)
        pieSet.valueTextColor = .black
        pieSet.valueFormatter = DefaultValueFormatter(decimals: 0)
        pieSet.sliceSpace = 1
        
        let l = pieChart.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.xEntrySpace = 10
        l.yEntrySpace = 0
        
        pieChart.holeColor = .clear
        pieChart.entryLabelFont = UIFont.systemFont(ofSize: 10)
        pieChart.entryLabelColor = .black
        pieChart.isUserInteractionEnabled = false
        pieChart.drawEntryLabelsEnabled = false
        pieChart.noDataText = noDataAvailableMessage
        pieChart.data = data
        pieChart.notifyDataSetChanged()
        pieChart.animate(yAxisDuration: 0.5)
        
    }
    
    private func configureBarChart(filter: ChartsFilter) {
        guard let barSets = presenter?.prepareBarChartDataSet(filter: filter), !barSets.isEmpty else {
            barChart.data = nil
            return
        }
        let data = BarChartData()
        
        barSets.forEach { data.addDataSet($0) }
        
        barChart.rightAxis.enabled = false
        
        barChart.xAxis.enabled = false
        barChart.dragEnabled = false
        barChart.isUserInteractionEnabled = false
        barChart.noDataText = noDataAvailableMessage
        barChart.data = data
        barChart.animate(yAxisDuration: 0.5)
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
        setShadowFor(view: pieChartContainerView)
        setShadowFor(view: barChartContainerView)
        
        lineChartLabel.text = lineGraphLabelConst
        pieChartLabel.text = pieGraphLabelConst
        barChartLabel.text = barGraphLabelConst
        
        lineChartLabel.font = UIFont.systemFont(ofSize: labelFontSize)
        pieChartLabel.font = UIFont.systemFont(ofSize: labelFontSize)
        barChartLabel.font = UIFont.systemFont(ofSize: labelFontSize)
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
        configurePieChart(filter: filter)
        configureBarChart(filter: filter)
    }
}
