//
//  BillDetailsPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 08.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import Foundation

class BillDetailsPresenter {
    //MARK: - Properties
    var billDetailsCreationState: BillDetailsCreationState = .defaultState
    var model: Bill?
    weak var view: IBillDetailsVC?
    weak var superPresenter: IHomePresenter?
    private var coreDataManager: ICoreDataManager
    private var router: IRouter
    private var category: Category?
    
    //MARK: - Init
    init(view: IBillDetailsVC, router: IRouter, model: Bill? = nil, superPresenter: IHomePresenter? = nil, coreDataManager: ICoreDataManager) {
        self.view = view
        self.router = router
        self.model = model
        self.category = model?.category
        self.superPresenter = superPresenter
        self.coreDataManager = coreDataManager 
    }
    //MARK: - Func
    
    private func createNewBill(newBill: Bill, invoice: Invoice) {
        
        let result = coreDataManager.createNewBill(bill: newBill, invoice: invoice)
        
        switch result {
        case .success(_):
            dismissModule { [unowned self] in
                self.superPresenter?.presentBillIntoUI(bill: newBill, billDetailsCreationState: self.billDetailsCreationState)
            }
        case .failure(let errro):
            print(errro)
        }
    }
    
    private func updateBill(newBill: Bill, invoice: Invoice) {
        let result = coreDataManager.updateBill(bill: newBill)
        
        switch result {
        case .success(_):
            dismissModule { [unowned self] in
                self.superPresenter?.presentBillIntoUI(bill: newBill, billDetailsCreationState: self.billDetailsCreationState)
            }
            
        case .failure(let error):
            print(error)
        }
    }
    
    private func isNeedToSaveChanges(newBill: Bill) -> Bool {
        guard let model = model else { return true }
        guard newBill == model else { return true }
        return false
    }
    
    private func dismissModule(complition: (() -> ())?) {
        router.dismissModuleFromHomeNavigation(complition: complition)
    }
}

extension BillDetailsPresenter: IBillDetailsPresenter {
    
    func saveButtonTapped(name: String, value: Double, billState: BillState, description: String?) {
        
        guard let category = category else { return }
        guard let invoice = superPresenter?.currentInvoice else { return }
        let value = billState == .expense ? value * -1 : value
        
        switch billDetailsCreationState {
        case .creating:
            let bill = Bill(value: value,
                            currency: invoice.currency,
                            billName: name,
                            billDescription: description ?? "",
                            category: category)
            createNewBill(newBill: bill, invoice: invoice)
        case .editing:
            guard let model = model else { return }
            let bill = Bill(value: value,
                            currency: invoice.currency,
                            billName: name,
                            billDescription: description ?? "",
                            category: category,
                            modifiedDate: Date(),
                            creationDate: model.creationDate)
            guard isNeedToSaveChanges(newBill: bill) else { dismissModule(complition: nil); return }
            updateBill(newBill: bill, invoice: invoice)
        case .defaultState:
            break
        }
    }
    
    func categorySelectedWithData(category: Category) {
        self.category = category
        view?.setCategory(name: category.name)
    }
    
    func categoryFieldTapped(transition: PanelTransition) {
        router.showBillCategoryModule(transition: transition, superPresenter: self)
    }
}
