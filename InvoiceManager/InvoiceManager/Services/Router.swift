//
//  Router.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//


import UIKit

protocol IRouterMain {
    var tabBarController: ITabBarVC? { get set }
    var assemblyBuilder: IAssembleBuilder? { get set }
}

protocol IRouter: IRouterMain {
    func initiateTabBar()
    func showBillDetailModule(superPresenter: IHomePresenter, model: Bill?)
    func showBillCategoryModule(transition: PanelTransition, superPresenter: IBillDetailsPresenter)
    func dismissModuleFromHomeNavigation(complition: (() -> ())?)
    func showNewInvoiceModule(superPresenter: IHomePresenter)
    func showCategorisedBillsModule()
}

class Router: IRouter {

    //MARK: - Properties
    var tabBarController: ITabBarVC?
    var assemblyBuilder: IAssembleBuilder?

    private var homeNavigationController: UINavigationController?
    private var categoryNavigationController: UINavigationController?
    private var chartNavigationsController: UINavigationController?
    private var profileNavigationsController: UINavigationController?

    //MARK: - Init
    init(tabBar: ITabBarVC, assembler: IAssembleBuilder) {
        self.tabBarController = tabBar
        self.assemblyBuilder = assembler
    }

    //MARK: - Func
    func initiateTabBar() {
        guard let tabBar = tabBarController else { return }
        tabBar.configureTabBar(router: self)
        guard let controllers = tabBar.viewControllers as? [UINavigationController] else { return }

        for item in controllers {
            if item.viewControllers[0] is HomeVC {
                self.homeNavigationController = item
                continue
            }

            if item.viewControllers[0] is CategoryVC {
                self.categoryNavigationController = item
                continue
            }

            if item.viewControllers[0] is ChartVC {
                self.chartNavigationsController = item
                continue
            }

            if item.viewControllers[0] is ProfileVC {
                self.profileNavigationsController = item
                continue
            }
        }
    }
    
    func showBillDetailModule(superPresenter: IHomePresenter, model: Bill?) {
        guard let view = assemblyBuilder?.createBillDetailsModule(router: self, superPresenter: superPresenter, model: model) else { return }
        
        homeNavigationController?.pushViewController(view, animated: true)
    }
    
    func showBillCategoryModule(transition: PanelTransition, superPresenter: IBillDetailsPresenter) {
        guard let view = assemblyBuilder?.createBillCategoryModule(router: self, transition: transition, superPresenter: superPresenter) else { return }
        homeNavigationController?.present(view, animated: true)
        
    }
    
    func dismissModuleFromHomeNavigation(complition: (() -> ())? = nil) {
        homeNavigationController?.popViewController(completion: complition)
    }
    
    func showNewInvoiceModule(superPresenter: IHomePresenter) {
        guard let view = assemblyBuilder?.createNewInvoiceModule(router: self, superPresenter: superPresenter) else { return }
        homeNavigationController?.pushViewController(view, animated: true)
    }
    
    func showCategorisedBillsModule() {
        guard let view = assemblyBuilder?.createCategorisedBillsModule(router: self) else { return }
        categoryNavigationController?.pushViewController(view, animated: true)
    }
}
