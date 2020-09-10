//
//  BillCategoryTableViewCell.swift
//  InvoiceManager
//
//  Created by Tianid on 10.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class BillCategoryTableViewCell: UITableViewCell {
    //MARK: - Properties
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    //MARK: - Init
    //MARK: - Func
    
    private func configureCell() {
        selectionStyle = .none
        backgroundColor = .clear
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
