//
//  ISPHomeViewCell.swift
//  InvoiceManager
//
//  Created by Tianid on 07.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

protocol ISPHomeViewCell {
    var model: [Bill] { get set }
    var superPresenter: ISPHomeView? { get set }
}
