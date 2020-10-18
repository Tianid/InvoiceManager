//
//  SIMOperation.swift
//  InvoiceManager
//
//  Created by Tianid on 18.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

class SIMOperation<T>: Operation {
    var result: T?
    private var action: (() -> T?)
    
    init(action: @escaping (() -> T?)) {
        self.action = action
    }
    
    override func main() {
        if isCancelled {
            return
        }
        result = action()
    }
}

