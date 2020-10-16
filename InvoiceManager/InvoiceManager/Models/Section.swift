//
//  Section.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

struct SuperSection {
    let section: Section
    let categorys: [Category]
}

struct Section: Equatable, Codable {
    //MARK: - Properties
    let name: String
    let categoryCount: Int
    //MARK: - Init
    //MARK: - Func
}
