//
//  ProfilePresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

class ProfilePresenter {
    
    //MARK: - Properties
    private weak var view: IProfileVC?
    private var router: IRouter
    
    //MARK: - Init
    init(view: IProfileVC, router: IRouter) {
        self.view = view
        self.router = router
    }
    
    //MARK: - Func
}

extension ProfilePresenter: IProfilePresenter {
    
}
