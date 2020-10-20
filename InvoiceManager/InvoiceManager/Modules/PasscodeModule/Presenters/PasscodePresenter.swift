//
//  PasscodePresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 20.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class PasscodePresenter {
    private var router: IRouter
    private var view: IPasscodeVC
    
    init(router: IRouter, view: IPasscodeVC) {
        self.router = router
        self.view = view
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PasscodePresenter: IPasscodePresenter {
    
}
