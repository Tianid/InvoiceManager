//
//  BillCategoryPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 10.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

class BillCategoryPresenter {
    //MARK: - Properties
    var model: [Category]
    weak var view: IBillCategoryVC?
    weak var superPresenter: IBillDetailsPresenter?
    private var router: IRouter
    
    //MARK: - Init
    init(view: IBillCategoryVC, router: IRouter, model: [Category], superPresenter: IBillDetailsPresenter? = nil) {
        self.view = view
        self.router = router
        self.model = model
        self.superPresenter = superPresenter
    }
    //MARK: - Func
}

extension BillCategoryPresenter: IBillCategoryPresenter {
    func dismissCategory() {
        view?.dismissBillCategory(complition: nil)
    }
    
    func categorySelected(index: Int) {
        let category = model[index]
        view?.dismissBillCategory(complition: { [weak self] in
            self?.superPresenter?.categorySelectedWithData(category: category)
        })
    }
}
