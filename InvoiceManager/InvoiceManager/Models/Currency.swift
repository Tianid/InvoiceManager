//
//  Currency.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//



enum Currency: String {
    case EUR, RUB, BYN, UAH, USD, GBP, JPY, none
    
    var symbolRaw: String {
        get {
            symbol.rawValue
        }
    }
    
    var symbol: CurrencySymbol {
        get {
            switch self {
            case .EUR:
                return .EUR
            case .RUB:
                return .RUB
            case .BYN:
                return .BYN
            case .UAH:
                return .UAH
            case .USD:
                return .USD
            case .GBP:
                return .GBP
            case .JPY:
                return .JPY
            case .none:
                return .none
            }
        }
    }
}

enum CurrencySymbol: String {
    case EUR = "€"
    case RUB = "₽"
    case BYN = "Br"
    case UAH = "₴"
    case USD = "$"
    case GBP = "£"
    case JPY = "¥"
    case none = ""
}
