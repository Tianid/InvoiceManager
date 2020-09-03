//
//  NewBillPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 03.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

class NewBillPresenter {
    //MARK: - Properties
    private weak var view: INewBillVC?
    private var router: IRouter
    
    //MARK: - Init
    init(view: INewBillVC, router: IRouter) {
        self.view = view
        self.router = router
    }
    //MARK: - Func
}

extension NewBillPresenter: INewBillPresenter {
    
}
