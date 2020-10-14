//
//  CDOperation.swift
//  InvoiceManager
//
//  Created by Tianid on 14.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class CDOperation<T>: AsyncOperation {
    var result: T?
    private var action: (() -> T)
    
    init(action: @escaping (() -> T)) {
        self.action = action
    }
    
    override func main() {
        result = action()
        self.finish()
    }
}
