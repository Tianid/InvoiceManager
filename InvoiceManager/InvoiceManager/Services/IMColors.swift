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
    
    static var colors: [String: UIColor] = ["Games": CategoryColors.gamesColor,
                                     "Books": CategoryColors.booksColor,
                                     "Cinema": CategoryColors.cinemaColor,
                                     "Theater": CategoryColors.theaterColor,
                                     "Furniture": CategoryColors.fruitsColor,
                                     "Repairs": CategoryColors.repairsColor,
                                     "Bills": CategoryColors.billsColor,
                                     "Rubish": CategoryColors.rubishColor,
                                     "Vegetables": CategoryColors.vegetablesColor,
                                     "Fruits": CategoryColors.fruitsColor,
                                     "Sweets": CategoryColors.sweetsColor
    ]
    
    static var sortedColors: [UIColor] {
        let sortedKeys = CategoryColors.colors.keys.sorted { $0 > $1 }
        var array = [UIColor]()
        sortedKeys.forEach {
            array.append(CategoryColors.colors[$0]!)
        }
        return array
    }
    
    static var gamesColor: UIColor {
        #colorLiteral(red: 0.3062085792, green: 0.6944523014, blue: 0.890372152, alpha: 1)
    }
    static var booksColor: UIColor {
        #colorLiteral(red: 0.3355658812, green: 0.1835916248, blue: 1, alpha: 1)
    }
    static var cinemaColor: UIColor {
        #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    }
    static var theaterColor: UIColor {
        #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    }
    static var furnituresColor: UIColor {
        #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    }
    static var repairsColor: UIColor {
        #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
    }
    static var billsColor: UIColor {
        #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    }
    static var rubishColor: UIColor {
        #colorLiteral(red: 0.395731367, green: 0.4356711784, blue: 0.9686274529, alpha: 1)
    }
    static var vegetablesColor: UIColor {
        #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
    }
    static var fruitsColor: UIColor {
        #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    }
    static var sweetsColor: UIColor {
        #colorLiteral(red: 0.6532844495, green: 0.3634540409, blue: 0.9106717957, alpha: 1)
    }
}
