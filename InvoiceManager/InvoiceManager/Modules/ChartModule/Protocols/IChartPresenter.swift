//
//  IChartPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

protocol IChartPresenter {
    var model: [Invoice]! { get set }
    func prepareCollectionViewCell(cell: ChartViewCell, index: Int) -> ChartViewCell
    func refreshChartData(isUseBackground: Bool, complition: (() -> ())?)
    func setUserInfo(userInfo: [AnyHashable: Any], complition: (() -> ())?)
}
