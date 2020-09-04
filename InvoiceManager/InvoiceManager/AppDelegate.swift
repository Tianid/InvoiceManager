//
//  AppDelegate.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupRoot()
        return true
    }
    
    private func initiate() -> UIViewController {
        let assembler = AssemblerModuleBuilder()
        let tabBar = TabBarVC()
        let router = Router(tabBar: tabBar, assembler: assembler)
        
        let presenter = TabBarPresenter(view: tabBar, router: router)
        tabBar.presenter = presenter
        
        router.initiateTabBar()
        return tabBar
    }
    
    private func setupRoot() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabBar = initiate()
        let testView = ViewController()
        testView.testData = testBills1
        let tets = UITabBarController()
        tets.viewControllers = [testView]
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
    }
}

