//
//  ChartPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import Foundation

enum ChartsFilter: String {
    case Day, Month, Year, Alltime = "All time"
}

class ChartPresenter {
    
    //MARK: - Properties
    var model: [Invoice]!
    private weak var view: IChartVC?
    private var router: IRouter
    private var coreDataManager: ICoreDataManager
    
    //MARK: - Init
    init(view: IChartVC, router: IRouter, coreDataManager: ICoreDataManager) {
        self.view = view
        self.router = router
        self.coreDataManager = coreDataManager
    }
    
    //MARK: - Func
    
    private func createAsyncOperation(isUseBackground: Bool, complition: (() -> ())?) {
        let operation = AIMOperation<[Invoice]> { [weak self] in
            let model = self?.coreDataManager.fetchAllInvoicesWithAllBills(predicate: nil, sortDescriptors: [NSSortDescriptor(key: "creationDate", ascending: true)], isUsedBackgroundContext: isUseBackground)
            return model
        }
        operation.completionBlock = { [weak self] in
            self?.model = operation.result
            DispatchQueue.main.async {
                complition?()
            }
        }
        OperationQueue().addOperation(operation)
    }
    
    private func createSyncOperation(isUseBackground: Bool, complition: (() -> ())?) {
        let operation = SIMOperation<[Invoice]> { [weak self] in
            let model = self?.coreDataManager.fetchAllInvoicesWithAllBills(predicate: nil, sortDescriptors: [NSSortDescriptor(key: "creationDate", ascending: true)], isUsedBackgroundContext: isUseBackground)
            return model
        }
        operation.completionBlock = { [weak self] in
            self?.model = operation.result
            DispatchQueue.main.async {
                complition?()
            }
        }
        OperationQueue().addOperation(operation)
    }
}

extension ChartPresenter: IChartPresenter {
    func setUserInfo(userInfo: [AnyHashable : Any], complition: (() -> ())?) {
        let model = userInfo["IMData"] as? [Invoice]
        self.model = model ?? []
        complition?()
    }
    
    func prepareCollectionViewCell(cell: ChartViewCell, index: Int) -> ChartViewCell {
        let lModel = model[index]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        
        cell.presenter = PChartViewCell(model: lModel)
        cell.invoiceNameLabel.text = lModel.name
        cell.curentDataLabel.text = dateFormatter.string(from: Date())
        cell.curentBalanceLabel.text = String(lModel.balance).currencySetFormatting(currencySymbol: lModel.currency.symbolRaw)
        return cell
    }
    
    func refreshChartData(isUseBackground: Bool = false, complition: (() -> ())?) {
        if isUseBackground {
            createAsyncOperation(isUseBackground: isUseBackground, complition: complition)
        } else {
            createSyncOperation(isUseBackground: isUseBackground, complition: complition)
        }
    }
}
