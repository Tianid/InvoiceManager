//
//  BillDetailsPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 08.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

class BillDetailsPresenter {
    //MARK: - Properties
    weak var view: IBillDetailsVC?
    private var router: IRouter
    //MARK: - Init
    init(view: IBillDetailsVC, router: IRouter) {
        self.view = view
        self.router = router
    }
    //MARK: - Func
}

extension BillDetailsPresenter: IBillDetailsPresenter {
    
    func categoryFieldTapped(transition: PanelTransition) {
        guard let v = router.initCategoryActionSheet(transition: transition) else { return  }
        view?.showCategoryActionSheet(view: v)
    }
}
