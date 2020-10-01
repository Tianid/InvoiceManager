//
//  String+currensyFormatting.swift
//  InvoiceManager
//
//  Created by Tianid on 23.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

extension String {
    
    private func prepareString() -> NSNumber {
        var amountWithPrefix = self
        var number: NSNumber!
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        return number
    }
    
    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.usesGroupingSeparator = true
        formatter.locale = .current
        
        number = prepareString()
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        let val = formatter.string(from: number)!.trimmingCharacters(in: .whitespaces)
        
        return val
    }
    
    func formattedStringToDouble() -> Double {
        let number = prepareString()
        return number.doubleValue
    }
    
    func currencySetFormatting(currencySymbol: String?) -> String? {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = currencySymbol ?? ""
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.usesGroupingSeparator = true
        formatter.locale = .current
        
        let amountWithPrefix = self
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: double)
        
        let val = formatter.string(from: number)!.trimmingCharacters(in: .whitespaces)
        return val
    }
}
