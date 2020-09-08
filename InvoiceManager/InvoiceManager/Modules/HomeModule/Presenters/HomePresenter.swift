//
//  HomePresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class HomePresenter {
    //MARK: - Properties
    var model: InvoiceContainer
    private weak var view: IHomeVC?
    private var router: IRouter
    
    //MARK: - Init
    init(view: IHomeVC, router: IRouter, model: InvoiceContainer) {
        self.view = view
        self.router = router
        self.model = model
    }
    
    //MARK: - Func
}

extension HomePresenter: IHomePresenter {
    
    func generateSPHomeView(view: IHomeView) -> ISPHomeView {
        let presener = SPHomeView(superPresenter: self, model: model, view: view)
        return presener
    }
}
