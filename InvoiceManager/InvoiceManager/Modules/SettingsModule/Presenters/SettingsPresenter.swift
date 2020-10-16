//
//  SettingsPresenter.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//
import UIKit

enum BackupAction {
    case Import, Export
}

class SettingsPresenter {
    
    //MARK: - Properties
    var model: [Settings]
    private weak var view: ISettingsVC?
    private var router: IRouter
    private var cryptedData: Data?
    
    //MARK: - Init
    init(view: ISettingsVC, router: IRouter, model: [Settings]) {
        self.view = view
        self.router = router
        self.model = model
    }
    
    //MARK: - Func
    
    private func fileActivityItem(data: Data) -> UIActivityViewController {
        let temp = NSTemporaryDirectory() + "backup-" + "\(UUID().uuidString)"
        let url = URL(fileURLWithPath: temp)
        do {
            try data.write(to: url)
        } catch {
            print(error)
        }
        
        let activity = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activity.completionWithItemsHandler = { (activity, success, items, error) in
            if success {
                do {
                    try FileManager.default.removeItem(at: url)
                } catch {
                    print(error)
                }
            }
        }
        return activity
    }
    
    private func importBakup(password: String) {
        //TODO: - Decrypt data
        let _data = self.cryptedData
        cryptedData = nil
        guard let data = _data else { cryptedData = nil; return }
        let result = SecurityService.decryptBackup(password: password, data: data)
        
        switch result {
        case .success(let _models):
            print(_models)
        case .failure(let error):
            print(error)
        }
    }
    
    private func exportBackup(password: String) {
        //TODO: - Encrypt data
        let result = SecurityService.encryptBackup(password: password)
        switch result {
        case .success(let json):
            guard let json = json else { return }
            let data = json.data(using: .utf8)!
            let activity = fileActivityItem(data: data)
            view?.presentVC(view: activity)
        case .failure(let error):
            print(error)
        }
    }
    
    private func backupAlert(message: String, action: BackupAction) -> UIAlertController {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addTextField { (field) in
            field.isSecureTextEntry = true
        }
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] (alert) in
            guard let password = alert.title else { return }
            switch action {
            case .Import:
                self?.importBakup(password: password)
            case .Export:
                self?.exportBackup(password: password)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
        return alert
    }
    
    private func dropAlert(message: String) ->  UIAlertController {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Drop", style: .destructive, handler: { (_) in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
        return alert
    }
}

extension SettingsPresenter: ISettingsPresenter {
    func cryptedItemSelected(data: Data) {
        self.cryptedData = data
        view?.presentVC(view: backupAlert(message: "Enter password", action: .Import))
    }
    
    
    func selectedItemAt(indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            view?.showDocumentPicker()
        case 1:
            view?.presentVC(view: backupAlert(message: "Enter password", action: .Export))
        case 2:
            break
        case 3:
            view?.presentVC(view: dropAlert(message: "You definitely want to drop all data ? (App need to restart)"))
        default:
            break
        }
    }
    
    func prepareTableViewCell(cell: UITableViewCell, indexPath: IndexPath) -> UITableViewCell {
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = model[indexPath.row].name
        cell.imageView?.image = UIImage(named: model[indexPath.row].imageName)
        return cell
    }
}
