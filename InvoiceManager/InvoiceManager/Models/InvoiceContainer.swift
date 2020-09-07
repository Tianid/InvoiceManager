//
//  InvoiceContainer.swift
//  InvoiceManager
//
//  Created by Tianid on 07.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

class InvoiceContainer {
    var invoices: [Invoice]
    
    init(model: [Invoice]) {
        self.invoices = model
    }
}
