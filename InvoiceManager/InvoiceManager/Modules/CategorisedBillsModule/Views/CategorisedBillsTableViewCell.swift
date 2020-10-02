//
//  CategorisedBillsTableViewCell.swift
//  InvoiceManager
//
//  Created by Tianid on 02.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class CategorisedBillsTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var billNameLabel: UILabel!
    @IBOutlet weak var billCategoryLabel: UILabel!
    @IBOutlet weak var billDateLabel: UILabel!
    @IBOutlet weak var billValueLabel: UILabel!
    @IBOutlet weak var billInvoiceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Func
    private func configureViews() {
        self.selectionStyle = .none
        iconImageView.layer.cornerRadius = iconImageView.frame.size.width / 2
    }
}
