//
//  ChartPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

class ChartPresenter {
    
    //MARK: - Properties
    var model: [Invoice]
    private weak var view: IChartVC?
    private var router: IRouter
    
    //MARK: - Init
    init(view: IChartVC, router: IRouter, model: [Invoice]) {
        self.view = view
        self.router = router
        self.model = model
    }
    
    //MARK: - Func
}

extension ChartPresenter: IChartPresenter {
    func prepareCollectionViewCell(cell: ChartViewCell, index: Int) -> ChartViewCell {
        let lModel = model[index]
        cell.presenter = PChartViewCell(model: lModel)
        cell.invoiceNameLabel.text = lModel.name
        return cell
    }
    
    
}
