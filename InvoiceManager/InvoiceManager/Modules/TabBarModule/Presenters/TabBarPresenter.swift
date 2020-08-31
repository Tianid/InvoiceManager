//
//  TabBarPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class TabBarPresenter {
    
    //MARK: - Properties
    private weak var view: ITabBarVC?
    private var router: IRouter
    
    //MARK: - Init
    init(view: ITabBarVC, router: IRouter) {
        self.view = view
        self.router = router
    }
    
    //MARK: - Func
}

extension TabBarPresenter: ITabBarPresenter {
    
}
