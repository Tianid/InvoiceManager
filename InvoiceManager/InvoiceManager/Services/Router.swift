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
    func initBillCategoryModule(transition: PanelTransition, superPresenter: IBillDetailsPresenter) -> UIViewController?
    func initBillDetailModule(superPresenter: IHomePresenter, model: Bill?, currency: Currency) -> UIViewController?
}

class Router: IRouter {

    //MARK: - Properties
    var tabBarController: ITabBarVC?
    var assemblyBuilder: IAssembleBuilder?

    private var homeNavigationController: UINavigationController?
    private var categoryNavigationController: UINavigationController?
    private var chartNavigationsController: UINavigationController?
    private var profileNavigationsController: UINavigationController?
    private var newBillVC: UIViewController?

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
            
            if item.viewControllers[0] is NewBillVC {
                self.newBillVC = item
                continue
            }
        }
    }
    
    func initBillCategoryModule(transition: PanelTransition, superPresenter: IBillDetailsPresenter) -> UIViewController? {
        return assemblyBuilder?.createBillCategoryModule(router: self, transition: transition, superPresenter: superPresenter)
    }
    
    func initBillDetailModule(superPresenter: IHomePresenter, model: Bill?, currency: Currency) -> UIViewController? {
        return assemblyBuilder?.createBillDetailsModule(router: self, superPresenter: superPresenter, model: model, currency: currency)
        
    }
}
