//
//  BillDetailsPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 08.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

class BillDetailsPresenter {
    //MARK: - Properties
    var billDetailsCreationState: BillDetailsCreationState = .defaultState
    var model: Bill?
    weak var view: IBillDetailsVC?
    weak var superPresenter: IHomePresenter?
    private var router: IRouter
    private var category: Category?
    private var currency: Currency
    //MARK: - Init
    init(view: IBillDetailsVC, router: IRouter, model: Bill? = nil, superPresenter: IHomePresenter? = nil, currency: Currency) {
        self.view = view
        self.router = router
        self.model = model
        self.superPresenter = superPresenter
        self.currency = currency
    }
    //MARK: - Func
}

extension BillDetailsPresenter: IBillDetailsPresenter {
    func deleteTapped() {
        guard let model = model, billDetailsCreationState == .editing else { return }
        
        router.dismissModuleFromHomeNavigation { [unowned self] in
            self.superPresenter?.deleteBillInModel(bill: model)
        }
    }
    
    func saveButtonTapped(name: String, value: Double, billState: BillState, description: String?) {
        
        var category: Category!
        
        if billDetailsCreationState == .editing {
            category = model?.category
        } else if billDetailsCreationState == .creating {
            category = self.category
        }
        
        guard let _ = category else { return }
        
        let value = billState == .expense ? value * -1 : value
        
        let bill = Bill(value: value,
                        currency: currency,
                        billName: name,
                        billDescription: description ?? "",
                        category: category)
        
        router.dismissModuleFromHomeNavigation(complition: { [unowned self] in
            self.superPresenter?.transferNewBill(bill: bill, billDetailsCreationState: self.billDetailsCreationState)
        })
    }
    
    func categorySelectedWithData(category: Category) {
        self.category = category
        view?.setCategory(name: category.name)
    }
    
    func categoryFieldTapped(transition: PanelTransition) {
        router.showBillCategoryModule(transition: transition, superPresenter: self)
    }
}
