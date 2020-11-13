//
//  IMColors.swift
//  InvoiceManager
//
//  Created by Tianid on 13.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit
import Foundation

class CategoryColors {
    
    static var colors: [String: UIColor] = ["Books" : CategoryColors.booksColor,
                                            "Games" : CategoryColors.gamesColor,
                                            "Movies & Series" : CategoryColors.cinemaColor,
                                            "Museums" : CategoryColors.museums,
                                            "Music" : CategoryColors.music,
                                            "Theater" : CategoryColors.theaterColor,
                                            "Bread" : CategoryColors.breadColor,
                                            "Cereals" : CategoryColors.cerealsColor,
                                            "Chicken" : CategoryColors.chickenColor,
                                            "Fish" : CategoryColors.fishColor,
                                            "Food" : CategoryColors.foodColor,
                                            "Fruits" : CategoryColors.fruitsColor,
                                            "Groats" : CategoryColors.groatsColor,
                                            "Juice" : CategoryColors.juiceColor,
                                            "Meat" : CategoryColors.meatColor,
                                            "Soda" : CategoryColors.sodaColor,
                                            "Sweets" :  CategoryColors.sweetsColor,
                                            "Vegetables" : CategoryColors.vegetablesColor,
                                            "Water" : CategoryColors.waterColor,
                                            "Bills" : CategoryColors.billsColor,
                                            "Cleaning" : CategoryColors.cleaningColor,
                                            "Furniture" : CategoryColors.furnituresColor,
                                            "Household" : CategoryColors.householdColor,
                                            "Repairs" : CategoryColors.repairsColor,
                                            "Car" : CategoryColors.carColor,
                                            "Clothes" : CategoryColors.clothesColor,
                                            "Credits" : CategoryColors.creaditsColor,
                                            "Electronics" : CategoryColors.electronicsColor,
                                            "Footwear" : CategoryColors.footwearColor,
                                            "Gifts" : CategoryColors.giftsColor,
                                            "Journeys" : CategoryColors.journeysColor,
                                            "Other" : CategoryColors.otherColor,
                                            "Salary" : CategoryColors.salaryColor,
                                            "Subscriptions" : CategoryColors.subscriptionsColor,
                                            "Tickets" : CategoryColors.ticketsColor,
                                            "import": CategoryColors.importColor,
                                            "export" : CategoryColors.exportColor,
                                            "security" : CategoryColors.securityColor,
                                            "drop" : CategoryColors.dropColor
                                            
    ]
    
    static var sortedColors: [UIColor] {
        let sortedKeys = CategoryColors.colors.keys.sorted { $0 > $1 }
        var array = [UIColor]()
        sortedKeys.forEach {
            array.append(CategoryColors.colors[$0]!)
        }
        return array
    }

    // entertainment
    
    static var booksColor: UIColor {
        #colorLiteral(red: 0.3355658812, green: 0.1835916248, blue: 1, alpha: 1)
    }
    
    static var gamesColor: UIColor {
        #colorLiteral(red: 0.3062085792, green: 0.6944523014, blue: 0.890372152, alpha: 1)
    }
    
    static var cinemaColor: UIColor {
        #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    }
    
    static var museums: UIColor {
        #colorLiteral(red: 0.9722000872, green: 1, blue: 0.3189911879, alpha: 1)
    }
    
    static var music: UIColor {
        #colorLiteral(red: 0.189666475, green: 0.7174413071, blue: 0.3421163618, alpha: 1)
    }
    
    static var theaterColor: UIColor {
        #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    }
    
    // food-water
    
    static var breadColor: UIColor {
        #colorLiteral(red: 0.1025904833, green: 0.6651996024, blue: 0.918900698, alpha: 1)
    }
    
    static var cerealsColor: UIColor {
        #colorLiteral(red: 0.3950648179, green: 0.3028458261, blue: 1, alpha: 1)
    }
    
    static var chickenColor: UIColor {
        #colorLiteral(red: 0.700705901, green: 0.6746917395, blue: 0.2810704224, alpha: 1)
    }
    
    static var fishColor: UIColor {
        #colorLiteral(red: 0.2265966597, green: 0.5145926681, blue: 1, alpha: 1)
    }
    
    static var foodColor: UIColor {
        #colorLiteral(red: 1, green: 0.5485919657, blue: 0.1818932575, alpha: 1)
    }
    
    static var fruitsColor: UIColor {
        #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    }
    
    static var groatsColor: UIColor {
        #colorLiteral(red: 0.8061098319, green: 1, blue: 0.8041065977, alpha: 1)
    }
    
    static var juiceColor: UIColor {
        #colorLiteral(red: 1, green: 0.6951925559, blue: 0.5277553908, alpha: 1)
    }
    
    static var meatColor: UIColor {
        #colorLiteral(red: 1, green: 0.1298170653, blue: 0.1021283623, alpha: 1)
    }
    
    static var sodaColor: UIColor {
        #colorLiteral(red: 1, green: 0.9804236447, blue: 0.1104061057, alpha: 1)
    }
    
    static var sweetsColor: UIColor {
        #colorLiteral(red: 0.6532844495, green: 0.3634540409, blue: 0.9106717957, alpha: 1)
    }
    
    static var vegetablesColor: UIColor {
        #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
    }
    
    static var waterColor: UIColor {
        #colorLiteral(red: 0.6102337834, green: 0.6823654708, blue: 1, alpha: 1)
    }
    
    // home
    
    static var billsColor: UIColor {
        #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    }
    
    static var cleaningColor: UIColor {
        #colorLiteral(red: 1, green: 0.6469490039, blue: 0.8156951279, alpha: 1)
    }
    
    static var furnituresColor: UIColor {
        #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    }
    
    static var householdColor: UIColor {
        #colorLiteral(red: 0, green: 0.6936576094, blue: 1, alpha: 1)
    }
    
    static var repairsColor: UIColor {
        #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
    }
    
    // others-salary
    
    static var carColor: UIColor {
        #colorLiteral(red: 1, green: 0.2486629336, blue: 0.06462054187, alpha: 1)
    }
    
    static var clothesColor: UIColor {
        #colorLiteral(red: 0.1304481544, green: 0.04821729373, blue: 1, alpha: 1)
    }
    
    static var creaditsColor: UIColor {
        #colorLiteral(red: 0.3388329228, green: 1, blue: 0.6722504096, alpha: 1)
    }
    
    static var electronicsColor: UIColor {
        #colorLiteral(red: 0.7490821487, green: 1, blue: 0.0749570383, alpha: 1)
    }
    
    static var footwearColor: UIColor {
        #colorLiteral(red: 1, green: 0.6598298937, blue: 0.05533357354, alpha: 1)
    }
    
    static var giftsColor: UIColor {
        #colorLiteral(red: 0.1778084141, green: 0.6930718591, blue: 0.07990161083, alpha: 1)
    }
    
    static var journeysColor: UIColor {
        #colorLiteral(red: 0.4341377683, green: 0.7149772498, blue: 0.7166283312, alpha: 1)
    }
    
    static var otherColor: UIColor {
        #colorLiteral(red: 0.7416094713, green: 0.09996643656, blue: 0.7603109138, alpha: 1)
    }
    
    static var salaryColor: UIColor {
        #colorLiteral(red: 0.1291999645, green: 0.3864992346, blue: 0.859870717, alpha: 1)
    }
    
    static var subscriptionsColor: UIColor {
        #colorLiteral(red: 0.626102368, green: 0.5960321645, blue: 0.8279465419, alpha: 1)
    }
    
    static var ticketsColor: UIColor {
        #colorLiteral(red: 0.8979814404, green: 0.6914855507, blue: 0.6320968245, alpha: 1)
    }
    
    static var importColor: UIColor {
        #colorLiteral(red: 0.4368702586, green: 0.5550274964, blue: 0.8979814404, alpha: 1)
    }
    
    static var exportColor: UIColor {
        #colorLiteral(red: 0.3972629957, green: 0.8979814404, blue: 0.3748951971, alpha: 1)
    }
    
    static var securityColor: UIColor {
        #colorLiteral(red: 0.1836205259, green: 0.7721165829, blue: 0.8979814404, alpha: 1)
    }
    
    static var dropColor: UIColor {
        #colorLiteral(red: 0.8979814404, green: 0.2037095064, blue: 0.1676354803, alpha: 1)
    }
}
