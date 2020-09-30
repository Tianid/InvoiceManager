//
//  AssemblerModuleBuilder.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//


import UIKit
import CoreData

protocol IAssembleBuilder {
    func createTabBarModule(router: IRouter) -> UITabBarController
    func createHomeModule(router: IRouter) -> UIViewController
    func createCategoryModule(router: IRouter) -> UIViewController
    func createChartModule(router: IRouter) -> UIViewController
    func createProfileModule(router: IRouter) -> UIViewController
    func createBillDetailsModule(router: IRouter, superPresenter: IHomePresenter?, model: Bill?) -> UIViewController
    func createBillCategoryModule(router: IRouter, transition: PanelTransition, superPresenter: IBillDetailsPresenter?) -> UIViewController
    func createNewInvoiceModule(router: IRouter, superPresenter: IHomePresenter?) -> UIViewController
}

class AssemblerModuleBuilder: IAssembleBuilder {
    private var context: NSManagedObjectContext
    private var coreDataManager: ICoreDataManager
    
    init(context: NSManagedObjectContext) {
        self.context = context
        self.coreDataManager = CoreDataManager(context: context)
    }
    
    func createTabBarModule(router: IRouter) -> UITabBarController {
        let view = TabBarVC()
        let presenter = TabBarPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createHomeModule(router: IRouter) -> UIViewController {
        let view = HomeVC()
        view.context = context
        let invoices = coreDataManager.fetchAllInvoicesWithAllBills()
        let invoiceContainer = InvoiceContainer(model: invoices)
        let presenter = HomePresenter(view: view, router: router, model: invoiceContainer, coreDataManager: coreDataManager)
        view.presenter = presenter
        return view
    }
    
    func createCategoryModule(router: IRouter) -> UIViewController {
        let view = CategoryVC()
        let model = coreDataManager.fetchAllSectionsWitAllCategorys()
        let presenter = CategoryPresenter(view: view, router: router, model: model)
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
    
    func createBillDetailsModule(router: IRouter, superPresenter: IHomePresenter?, model: Bill?) -> UIViewController {
        let view = BillDetailsVC()
        let presenter = BillDetailsPresenter(view: view, router: router, model: model, superPresenter: superPresenter, coreDataManager: coreDataManager)
        view.presenter = presenter
        return view
    }
    
    func createBillCategoryModule(router: IRouter, transition: PanelTransition, superPresenter: IBillDetailsPresenter?) -> UIViewController {
        let view = BillCategoryVC()
        view.transitioningDelegate = transition
        view.modalPresentationStyle = .custom
        let model = coreDataManager.fetchAllSectionsWitAllCategorys()

        let presenter = BillCategoryPresenter(view: view, router: router, model: model, superPresenter: superPresenter)
        view.presenter = presenter
        return view
    }
    
    func createNewInvoiceModule(router: IRouter, superPresenter: IHomePresenter?) -> UIViewController {
        let view = NewInvoiceVC()
        let presenter = NewInvoicePresenter(view: view, router: router, superPresenter: superPresenter, coreDataManager: coreDataManager)
        view.presenter = presenter
        return view
    }
}
