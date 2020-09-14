//
//  Category.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation

struct Category: Equatable {
    //MARK: - Properties
    let name: String
    let iconImage: String
    let section: Section
    //MARK: - Init
    //MARK: - Func
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.name == rhs.name &&
            lhs.iconImage == rhs.iconImage &&
            lhs.section == rhs.section
    }
}
