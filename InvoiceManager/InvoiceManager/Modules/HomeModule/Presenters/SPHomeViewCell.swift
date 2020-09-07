//
//  SPHomeViewCell.swift
//  InvoiceManager
//
//  Created by Tianid on 07.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

class SPHomeViewCell {
    
    //MARK: - Properties
    var model: [Bill]
    weak var superPresenter: ISPHomeView?
    private var invoiceIndex: Int
    
    //MARK: - Init
    init(model: [Bill], superPresenter: ISPHomeView, invoiceIndex: Int) {
        self.model = model
        self.superPresenter = superPresenter
        self.invoiceIndex = invoiceIndex
    }
    
    //MARK: - Func
}

extension SPHomeViewCell: ISPHomeViewCell {
    
}
