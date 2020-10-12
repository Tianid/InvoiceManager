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
    
    private var categoryView: ChartView? {
        guard isViewLoaded else { return nil }
        return (self.view as! ChartView)
    }
    
    private var segmentedControll: UISegmentedControl = {
        let view = UISegmentedControl(items: ["Day", "Month", "Year", "All time"])
        view.selectedSegmentIndex = 3
        return view
    }()
    
    //MARK: - Init
    //MARK: - Func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.titleView = segmentedControll
    }
    
    override func loadView() {
        let view = ChartView(frame: UIScreen.main.bounds)
        view.presenter = presenter
        self.view = view
    }
}

extension ChartVC: IChartVC {
    
}
