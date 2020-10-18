//
//  SettingsVC.swift
//  InvoiceManager
//
//  Created by Tianid on 31.08.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit
import MobileCoreServices

class SettingsVC: UIViewController {
    //MARK: - Properties
    var presenter: ISettingsPresenter?
    
    private var settingsView: SettingsView? {
        guard isViewLoaded else { return nil }
        return (self.view as! SettingsView)
    }
    //MARK: - Init
    //MARK: - Func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
    
    override func loadView() {
        let view = SettingsView(frame: UIScreen.main.bounds)
        view.presenter = presenter
        self.view = view
    }
}

extension SettingsVC: ISettingsVC {
    func presentVC(view: UIViewController) {
        if let popoverController = view.popoverPresentationController {
            popoverController.sourceView = settingsView
            popoverController.sourceRect = CGRect(x: settingsView!.bounds.midX, y: settingsView!.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        }
        present(view, animated: true)
    }
    
    func showDocumentPicker() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeItem as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        
        if let popoverController = documentPicker.popoverPresentationController {
            popoverController.sourceView = settingsView
            popoverController.sourceRect = CGRect(x: settingsView!.bounds.midX, y: settingsView!.bounds.midY, width: 0, height: 0)
        }
        self.present(documentPicker, animated: true)
    }
}

extension SettingsVC: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        do {
            let data = try Data(contentsOf: urls[0])
            //if data less or equal then 1 GB
            guard data.count <= 1073741824 else { return }
            presenter?.cryptedItemSelected(data: data)
        } catch {
            print(error)
        }
    }
}
