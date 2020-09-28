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
    private var coreDataManager: ICoreDataManager
    //MARK: - Init
    
    init(view: INewInvoiceVC, router: IRouter, superPresenter: IHomePresenter? = nil, coreDataManager: ICoreDataManager) {
        self.view = view
        self.router = router
        self.superPresenter = superPresenter
        self.coreDataManager = coreDataManager
    }
    //MARK: - Func
    
}

extension NewInvoicePresenter: INewInvoicePresenter {
    func saveNewInvoice(data: (String, Currency, String?)) {
        router.dismissModuleFromHomeNavigation(complition: { [weak self] in
            guard let result = self?.coreDataManager.createNewInvoice(data: data) else { return }
            
            switch result {
            case .success(let invoice):
                self?.superPresenter?.addNewInvoice(invoice: invoice)
            case .failure(_):
                break
            }
        })
    }
}
