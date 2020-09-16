//
//  NewInvoicePresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 16.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

class NewInvoicePresenter {
    //MARK: - Properties
    weak var view: INewInvoiceVC?
    private weak var superPresenter: IHomePresenter?
    private var router: IRouter
    //MARK: - Init
    
    init(view: INewInvoiceVC, router: IRouter, superPresenter: IHomePresenter? = nil) {
        self.view = view
        self.router = router
        self.superPresenter = superPresenter
    }
    //MARK: - Func
    
}

extension NewInvoicePresenter: INewInvoicePresenter {
    func saveNewInvoice(data: (String, Currency)) {
        router.dismissModuleFromHomeNavigation(complition: { [weak self] in
            self?.superPresenter?.addNewInvoice(data: data)
        })
    }
}
