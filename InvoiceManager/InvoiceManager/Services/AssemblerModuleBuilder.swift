//
//  AssemblerModuleBuilder.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//


import UIKit
import CoreData

enum DetailsVCPresentingType {
    case edit, readOnly
}

protocol IAssembleBuilder {
    func createTabBarModule(router: IRouter) -> UITabBarController
    func createHomeModule(router: IRouter) -> UIViewController
    func createCategoryModule(router: IRouter) -> UIViewController
    func createChartModule(router: IRouter) -> UIViewController
    func createSettingsModule(router: IRouter) -> UIViewController
    func createBillDetailsModule(router: IRouter, superPresenter: IHomePresenter?, model: Bill?, billDetailsPresentingType: DetailsVCPresentingType) -> UIViewController
    func createBillCategoryModule(router: IRouter, transition: PanelTransition, superPresenter: IBillDetailsPresenter?) -> UIViewController
    func createNewInvoiceModule(router: IRouter, superPresenter: IHomePresenter?) -> UIViewController
    func createCategorisedBillsModule(router: IRouter, category: Category) -> UIViewController
}

class AssemblerModuleBuilder: IAssembleBuilder {
    private var coreDataManager: ICoreDataManager
    
    init(coreDataManager: ICoreDataManager) {
        self.coreDataManager = coreDataManager
        SecurityService.setCoreDataManager(coreDataManager: coreDataManager)
    }
    
    func createTabBarModule(router: IRouter) -> UITabBarController {
        let view = TabBarVC()
        let presenter = TabBarPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createHomeModule(router: IRouter) -> UIViewController {
        let view = HomeVC()
        let invoices = coreDataManager.fetchAllInvoicesWithAllBills(predicate: nil, sortDescriptors: [NSSortDescriptor(key: "creationDate", ascending: true)], isUsedBackgroundContext: false)
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
        let presenter = ChartPresenter(view: view, router: router, coreDataManager: coreDataManager)
        view.presenter = presenter
        return view
    }
    
    func createSettingsModule(router: IRouter) -> UIViewController {
        let view = SettingsVC()
        let model = testSettings
        let presenter = SettingsPresenter(view: view, router: router, model: model)
        view.presenter = presenter
        return view
    }
    
    func createBillDetailsModule(router: IRouter, superPresenter: IHomePresenter?, model: Bill?, billDetailsPresentingType: DetailsVCPresentingType) -> UIViewController {
        let view = BillDetailsVC(billDetailsPresentingType: billDetailsPresentingType)
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
    
    func createCategorisedBillsModule(router: IRouter, category: Category) -> UIViewController {
        let view = CategorisedBillsVC()
        let model = coreDataManager.fetchBillsWithInvoices(by: category)
        let presenter = CategorisedBillsPresenter(view: view, router: router, model: model)
        view.presenter = presenter
        return view
    }
}
