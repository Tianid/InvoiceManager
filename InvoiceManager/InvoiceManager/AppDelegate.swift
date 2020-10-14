//
//  AppDelegate.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var container: NSPersistentContainer!
    var context: NSManagedObjectContext!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupCoreDataStack()
        preloadData()
        setupRoot()
        
        
        return true
    }
    
    private func initiate() -> UIViewController {
        let assembler = AssemblerModuleBuilder(context: container.viewContext, backgroundContext: container.newBackgroundContext())
        let tabBar = TabBarVC()
        let router = Router(tabBar: tabBar, assembler: assembler)
        
        let presenter = TabBarPresenter(view: tabBar, router: router)
        tabBar.presenter = presenter
        
        router.initiateTabBar()
        return tabBar
    }
    
    private func setupRoot() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabBar = self.initiate()
        let testView = ViewController()
        testView.testData = testBills1
        let tets = UITabBarController()
        tets.viewControllers = [testView]
        self.window?.rootViewController = tabBar
        self.window?.makeKeyAndVisible()
    }
    
    private func setupCoreDataStack() {
        self.container = createContainer()
        self.context = container.viewContext
        //        let context = container.viewContext
        //        let root = self.window?.rootViewController
        //        let vRoot = root as? ViewController
        //        vRoot?.context = context
        //        self.preloadData()
        //        self.getAllCategorys()
    }
    
    private func createContainer() -> NSPersistentContainer? {
        let container = NSPersistentContainer(name: "Modelv0.1")
        container.loadPersistentStores { (_, error) in
            guard error == nil else {
                fatalError("Failed to load store")
            }
        }
        
        return container
    }
    
    
    private func preloadData() {
        let preloadedDataKey = "didPreloadData"
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: preloadedDataKey) == false {
            guard let urlPath = Bundle.main.url(forResource: "PreloadedData", withExtension: "plist") else { return }
            let data = try! Data(contentsOf: urlPath)
            
            guard let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String: [String]] else { return }
            
            let backgroundContext = container.viewContext
            container.viewContext.automaticallyMergesChangesFromParent = true
            
            var keys = Array(plist.keys)
            keys.sort()
            
            for section in keys {
                let categorys = plist[section]
                let sectionCD = CDSection(context: backgroundContext)
                sectionCD.name = section
                sectionCD.creationDate = Date()
                sectionCD.modifiedDate = sectionCD.creationDate
                
                for category in categorys! {
                    let categoryCD = CDCategory(context: backgroundContext)
                    categoryCD.name = category
                    categoryCD.iconImageName = "NO IMAGE"
                    categoryCD.creationDate = Date()
                    categoryCD.modifiedDate = categoryCD.creationDate
                    sectionCD.addToCategory(categoryCD)
                }
            }
            
            do {
                try backgroundContext.save()
                userDefaults.set(true, forKey: preloadedDataKey)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func getAllCategorys() {
        let backgroundContext = container.newBackgroundContext()
        let request = NSFetchRequest<CDCategory>(entityName: "\(CDCategory.self)")
        let data = try! backgroundContext.fetch(request)
        
        
        for iten in data {
            print(iten.name)
            print(iten.iconImageName)
            print(iten.section?.name)
            
            print()
            
        }
    }
}

