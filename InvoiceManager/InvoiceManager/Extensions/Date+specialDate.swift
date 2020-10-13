//
//  Date+specialDate.swift
//  InvoiceManager
//
//  Created by Tianid on 13.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

extension Date {
    static var today: (start: Date, end: Date) { return (start: Date().startOfDay, end: Date().endOfDay) }
    static var thisMonth: (start: Date, end: Date) { return (start: Date().startOfMonth, end: Date().endOfMonth) }
    static var thisYear: (start: Date, end: Date) { return (start: Date().startOfYear, end: Date().endOfYear) }
    
    
    private var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    private var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    private var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: startOfDay)
        return Calendar.current.date(from: components)!
    }
    
    private var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth)!
    }
    
    private var startOfYear: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: startOfDay)
        return Calendar.current.date(from: components)!

    }
    
    private var endOfYear: Date {
        var components = DateComponents()
        components.year = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth)!
    }
}
