//
//  CategoryPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

class CategoryPresenter {
    //MARK: - Properties
    private weak var view: ICategoryVC?
    private var router: IRouter
    
    //MARK: - Init
    init(view: ICategoryVC, router: IRouter) {
        self.view = view
        self.router = router
    }
    
    //MARK: - Func
}

extension CategoryPresenter: ICategoryPresenter {
    
}
