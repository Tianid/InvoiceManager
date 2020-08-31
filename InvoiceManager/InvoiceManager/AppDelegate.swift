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
        
        router.initiateTabBar()
        return tabBar
    }
    
    private func setupRoot() {
        let tabBar = initiate()
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
    }
}

