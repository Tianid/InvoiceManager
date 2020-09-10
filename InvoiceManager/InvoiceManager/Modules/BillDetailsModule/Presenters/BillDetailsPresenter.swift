//
//  BillDetailsPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 08.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

class BillDetailsPresenter {
    //MARK: - Properties
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
    func saveButtonTapped(name: String, value: Double, billState: BillState, description: String?) {
        guard let category = category else { return }
        let value = billState == .expense ? value * -1 : value
        
        let bill = Bill(value: value,
                        currency: currency,
                        billName: name,
                        billDescription: description ?? "",
                        category: category)
        
        superPresenter?.transferNewBill(bill: bill)
        view?.dismissDetail()
    }
    
    func categorySelectedWithData(category: Category) {
        self.category = category
        view?.setCategory(name: category.name)
    }
    
    func categoryFieldTapped(transition: PanelTransition) {
        guard let v = router.initBillCategoryModule(transition: transition, superPresenter: self) else { return  }
        view?.showBillCategoryModule(view: v)
    }
}
