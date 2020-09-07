//
//  SPHomeView.swift
//  InvoiceManager
//
//  Created by Tianid on 07.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

class SPHomeView {
    //MARK: - Properties
    var model: InvoiceContainer
    weak var superPresenter: IHomePresenter?
    
    //MARK: - Init
    init(superPresenter: IHomePresenter, model: InvoiceContainer) {
        self.superPresenter = superPresenter
        self.model = model
    }
    
    //MARK: - Func

}

extension SPHomeView: ISPHomeView {
    func generateSPHomeViewCell(index: Int) -> ISPHomeViewCell {
        let presenter = SPHomeViewCell(model: model.invoices[index].bills, superPresenter: self, invoiceIndex: index)
        return presenter
    }
}
