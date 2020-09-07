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
    func getHomeNavigationControllerPresenter() -> IHomePresenter?
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
    
    func getHomeNavigationControllerPresenter() -> IHomePresenter? {
        guard let view = homeNavigationController?.viewControllers[0] as? HomeVC else { return nil }
        return view.presenter
    }
}
