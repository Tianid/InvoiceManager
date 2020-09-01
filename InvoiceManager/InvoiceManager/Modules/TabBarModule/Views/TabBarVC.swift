//
//  TabBarController.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    //MARK: - Properties
    var presenter: ITabBarPresenter?
    
    //MARK: - Init
    //MARK: - Func
    
}

extension TabBarVC: ITabBarVC {
    func configureTabBar(router: IRouter) {
        
        //MARK: Delete Test after all
        guard let assembler = router.assemblyBuilder else { return }
        
        let homeController = assembler.createHomeModule(router: router)
        let categoryController = assembler.createCategoryModule(router: router)
        let chartController = assembler.createChartModule(router: router)
        let profileController = assembler.createProfileModule(router: router)
        
        var homeItem: UITabBarItem!
        var categoryItem: UITabBarItem!
        var chartItem: UITabBarItem!
        var profileItem: UITabBarItem!
        
        if #available(iOS 13, *) {
            
            homeItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage:  UIImage(systemName: "house.fill"))
            categoryItem = UITabBarItem(title: "Category", image: UIImage(systemName: "tray.2"), selectedImage:  UIImage(systemName: "tray.2.fill"))
            chartItem = UITabBarItem(title: "Chart", image: UIImage(systemName: "chart.pie"), selectedImage:  UIImage(systemName: "chart.pie.fill"))
            profileItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage:  UIImage(systemName: "person.fill"))
        } else {
            
            homeItem = UITabBarItem(title: "Home", image: UIImage(named: "house"), selectedImage:  UIImage(named: "house.fill"))
            categoryItem = UITabBarItem(title: "Category", image: UIImage(named: "tray.2"), selectedImage:  UIImage(named: "tray.2.fill"))
            chartItem = UITabBarItem(title: "Chart", image: UIImage(named: "chart.pie"), selectedImage:  UIImage(named: "chart.pie.fill"))
            profileItem = UITabBarItem(title: "Profile", image: UIImage(named: "person"), selectedImage:  UIImage(named: "person.fill"))
        }
        
        homeController.tabBarItem = homeItem
        categoryController.tabBarItem = categoryItem
        chartController.tabBarItem = chartItem
        profileController.tabBarItem = profileItem
        
        let homeNavigationController = UINavigationController(rootViewController: homeController)
        let categoryNavigationController = UINavigationController(rootViewController: categoryController)
        let chartNavigationsController = UINavigationController(rootViewController: chartController)
        let profileNavigationsController = UINavigationController(rootViewController: profileController)
        
        let controllers = [homeNavigationController, categoryNavigationController, chartNavigationsController, profileNavigationsController]
        
        self.viewControllers = controllers
    }
}
