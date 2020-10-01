//
//  CategorisedBillsPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 01.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

class CategorisedBillsPresenter {
    //MARK: - Properties
    private weak var view: ICategorisedBillsVC?
    private var router: IRouter
    //MARK: - Init
    
    init(view: ICategorisedBillsVC, router: IRouter) {
        self.view = view
        self.router = router
    }
    //MARK: - Func
}

extension CategorisedBillsPresenter: ICategorisedBillsPresenter {
    
}
