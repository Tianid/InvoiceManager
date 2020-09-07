//
//  ISPHomeVIew.swift
//  InvoiceManager
//
//  Created by Tianid on 07.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

protocol ISPHomeView: class {
    var model: InvoiceContainer { get set }
    var superPresenter: IHomePresenter? { get set }
    func generateSPHomeViewCell(index: Int) -> ISPHomeViewCell
}
