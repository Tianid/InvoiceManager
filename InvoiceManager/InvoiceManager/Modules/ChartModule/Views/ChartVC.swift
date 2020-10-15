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
    
    private var chartView: ChartView? {
        guard isViewLoaded else { return nil }
        return (self.view as! ChartView)
    }
    
    private var segmentedControll: UISegmentedControl = {
        let view = UISegmentedControl(items: [ChartsFilter.Day.rawValue, ChartsFilter.Month.rawValue, ChartsFilter.Year.rawValue, ChartsFilter.Alltime.rawValue])

        view.selectedSegmentIndex = 3
        return view
    }()
    
    //MARK: - Init
    //MARK: - Func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
    }
    
    override func loadView() {
        let view = ChartView(frame: UIScreen.main.bounds)
        view.presenter = presenter
        self.view = view
    }
    
    private func configureController() {
        view.backgroundColor = UIColor(named: "CustomBackground")
        self.navigationItem.titleView = segmentedControll
        segmentedControll.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        chartView?.viewDidLoad()
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        var filter: ChartsFilter?
        
        switch sender.selectedSegmentIndex {
        case 0:
            filter = ChartsFilter.Day
        case 1:
            filter = ChartsFilter.Month
        case 2:
            filter = ChartsFilter.Year
        case 3:
            filter = ChartsFilter.Alltime
        default:
            break
        }
        
        guard filter != nil else { return }
        chartView?.segmentChanged(filter: filter!)
    }
}

extension ChartVC: IChartVC {
    
}
