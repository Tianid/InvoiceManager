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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - ITabBarVC
extension TabBarVC: ITabBarVC {
    func configureTabBar(router: IRouter) {
        
        //MARK: Delete Test after all
        guard let assembler = router.assemblyBuilder else { return }
        
        let homeController = assembler.createHomeModule(router: router)
        let categoryController = assembler.createCategoryModule(router: router)
        let chartController = assembler.createChartModule(router: router)
        let settingsController = assembler.createSettingsModule(router: router)
        
        var homeItem: UITabBarItem!
        var categoryItem: UITabBarItem!
        var chartItem: UITabBarItem!
        var settingsItem: UITabBarItem!
        
        if #available(iOS 13, *) {
            
            homeItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage:  UIImage(systemName: "house.fill"))
            categoryItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "tray.2"), selectedImage:  UIImage(systemName: "tray.2.fill"))
            chartItem = UITabBarItem(title: "Charts", image: UIImage(systemName: "chart.pie"), selectedImage:  UIImage(systemName: "chart.pie.fill"))
            settingsItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), selectedImage:  UIImage(systemName: "gear"))
        } else {
            
            homeItem = UITabBarItem(title: "Home", image: UIImage(named: "house.png"), selectedImage:  UIImage(named: "house.fill.png"))
            categoryItem = UITabBarItem(title: "Categories", image: UIImage(named: "tray.2.png"), selectedImage:  UIImage(named: "tray.2.fill.png"))
            chartItem = UITabBarItem(title: "Charts", image: UIImage(named: "chart.pie.png"), selectedImage:  UIImage(named: "chart.pie.fill.png"))
            settingsItem = UITabBarItem(title: "Settings", image: UIImage(named: "gear.png"), selectedImage:  UIImage(named: "gear.png"))
        }
        
        homeController.tabBarItem = homeItem
        categoryController.tabBarItem = categoryItem
        chartController.tabBarItem = chartItem
        settingsController.tabBarItem = settingsItem
        
        let homeNavigationController = UINavigationController(rootViewController: homeController)
        let categoryNavigationController = UINavigationController(rootViewController: categoryController)
        let chartNavigationController = UINavigationController(rootViewController: chartController)
        let settingsNavigationController = UINavigationController(rootViewController: settingsController)
        
        let controllers = [homeNavigationController, categoryNavigationController, chartNavigationController, settingsNavigationController]
        
        self.viewControllers = controllers
    }
}
