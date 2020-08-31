//
//  ChartPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

class ChartPresenter {
    
    //MARK: - Properties
    private weak var view: IChartVC?
    private var router: IRouter
    
    //MARK: - Init
    init(view: IChartVC, router: IRouter) {
        self.view = view
        self.router = router
    }
    
    //MARK: - Func
}

extension ChartPresenter: IChartPresenter {
    
}
