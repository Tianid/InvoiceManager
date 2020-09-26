//
//  PHomeCollectionViewCell.swift
//  InvoiceManager
//
//  Created by Tianid on 25.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class PHomeCollectionViewCell {
    var invoice: CDInvoice
    var model: [CDBill]
    weak var superPresenter: IHomePresenter?
    
    init(invoice: CDInvoice) {
        self.invoice = invoice
        self.model = []
        self.model = loadBills() ?? []
    }
    
    private func loadBills() -> [CDBill]? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.context {
            let request = NSFetchRequest<CDBill>(entityName: "\(CDBill.self)")
            request.sortDescriptors = [NSSortDescriptor(key: "modifiedDate", ascending: false)]
            request.predicate = NSPredicate(format: "invoice.name == %@", invoice.name!)
            
            do {
                let bills = try context.fetch(request)
                return bills
            } catch {
                print(error.localizedDescription)
                return nil
            }
            
        }
        return nil
    }
    
}


extension PHomeCollectionViewCell: IPHomeCollectionViewCell {
    
    func reloadBills() {
        model = loadBills() ?? []
    }
    
}
