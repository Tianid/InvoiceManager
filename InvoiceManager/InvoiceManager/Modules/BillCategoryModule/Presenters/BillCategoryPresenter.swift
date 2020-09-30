//
//  BillCategoryPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 10.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit

class BillCategoryPresenter {
    //MARK: - Properties
    var model: [SuperSection]
    weak var view: IBillCategoryVC?
    weak var superPresenter: IBillDetailsPresenter?
    private var router: IRouter
    
    //MARK: - Init
    init(view: IBillCategoryVC, router: IRouter, model: [SuperSection], superPresenter: IBillDetailsPresenter? = nil) {
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
    
    func categorySelected(indexPath: IndexPath) {
        let category = model[indexPath.section].categorys[indexPath.row]
        view?.dismissBillCategory(complition: { [weak self] in
            self?.superPresenter?.categorySelectedWithData(category: category)
        })
    }
}
