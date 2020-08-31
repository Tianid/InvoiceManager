//
//  AssemblerModuleBuilder.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//


import UIKit

protocol IAssembleBuilder {
    func createTabBarModule(router: IRouter) -> UITabBarController
    func createHomeModule(router: IRouter) -> UIViewController
    func createCategoryModule(router: IRouter) -> UIViewController
    func createChartModule(router: IRouter) -> UIViewController
    func createProfileModule(router: IRouter) -> UIViewController
}

class AssemblerModuleBuilder: IAssembleBuilder {
    
    func createTabBarModule(router: IRouter) -> UITabBarController {
        let view = TabBarVC()
        let presenter = TabBarPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createHomeModule(router: IRouter) -> UIViewController {
        let view = HomeVC()
        let presenter = HomePresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createCategoryModule(router: IRouter) -> UIViewController {
        let view = CategoryVC()
        let presenter = CategoryPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createChartModule(router: IRouter) -> UIViewController {
        let view = ChartVC()
        let presenter = ChartPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createProfileModule(router: IRouter) -> UIViewController {
        let view = ProfileVC()
        let presenter = ProfilePresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
}
