//
//  Constatns.swift
//  InvoiceManager
//
//  Created by Tianid on 26.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

let CurrencyList: [Currency] = [.EUR, .GBP, .RUB, .BYN, .UAH, .JPY,.USD]
let SettingsList: [Settings] = [Settings(name: "Import backup", imageName: "import"),
                                Settings(name: "Export backup", imageName: "export"),
                                Settings(name: "Passcode", imageName: "security"),
                                Settings(name: "Drop data", imageName: "drop")]

let requireCurrentPasscodeConst = "requireCurrentPasscode"
let passcodeTypeConst = "passcodeType"
let keychainAccountConst = "keychainAccount"
let keychainPasscodeConst = "keychainPasscode"
