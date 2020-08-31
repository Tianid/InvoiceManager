//
//  HomePresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//


class HomePresenter {
    //MARK: - Properties
    private weak var view: IHomeVC?
    private var router: IRouter
    
    //MARK: - Init
    init(view: IHomeVC, router: IRouter) {
        self.view = view
        self.router = router
    }
    
    //MARK: - Func
}

extension HomePresenter: IHomePresenter {
    
}
