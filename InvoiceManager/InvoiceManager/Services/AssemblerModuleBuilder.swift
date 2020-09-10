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
    func createNewBillModule(router: IRouter) -> UIViewController
    func createBillDetailsModule(router: IRouter, superPresenter: IHomePresenter, model: Bill?, currency: Currency) -> UIViewController
    func createBillCategoryModule(router: IRouter, transition: PanelTransition, superPresenter: IBillDetailsPresenter) -> UIViewController
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
        let invoiceContainer = InvoiceContainer(model: testInvoices)
        let presenter = HomePresenter(view: view, router: router, model: invoiceContainer)
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
    
    func createNewBillModule(router: IRouter) -> UIViewController {
        let view = NewBillVC()
        let presenter = NewBillPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createBillDetailsModule(router: IRouter, superPresenter: IHomePresenter, model: Bill?, currency: Currency) -> UIViewController {
        let view = BillDetailsVC()
        let presenter = BillDetailsPresenter(view: view, router: router, model: model, superPresenter: superPresenter, currency: currency)
        view.presenter = presenter
        return view
    }
    
    func createBillCategoryModule(router: IRouter, transition: PanelTransition, superPresenter: IBillDetailsPresenter) -> UIViewController {
        let view = BillCategoryVC()
        view.transitioningDelegate = transition
        view.modalPresentationStyle = .custom
        
        let presenter = BillCategoryPresenter(view: view, router: router, model: [testSingleCategory], superPresenter: superPresenter)
        view.presenter = presenter
        
//        let view2 = ViewController()
        return view
    }


}
