//
//  HomeViewTableViewCell.swift
//  InvoiceManager
//
//  Created by Tianid on 02.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class HomeViewTableViewCell: UITableViewCell {
    //MARK: - Properties
    
    var isReadOnly = false {
        didSet {
            guard isReadOnly, deleteButton != nil else { return }
            deleteButton.removeFromSuperview()
        }
    }
    
    var presenter: IHomeViewTableViewCell?

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var billNameLabel: UILabel!
    @IBOutlet weak var billCategoryLabel: UILabel!
    @IBOutlet weak var billDateLabel: UILabel!
    @IBOutlet weak var billValueLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        guard let superView = self.superview as? UITableView else { return }
        guard let indexPath = superView.indexPath(for: self) else { return }
        presenter?.deleteButtonTapped(indexPath: indexPath)
    }
    
    //MARK: - Init
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
