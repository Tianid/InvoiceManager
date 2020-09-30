//
//  ExpandableListViewController.swift
//  InvoiceManager
//
//  Created by Tianid on 30.09.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

enum ELSection {
    case main
}

struct ELHeaderItem: Hashable {
    let title: String
    let symbols: [ELSymbolItem]
}

struct ELSymbolItem: Hashable {
    let name: String
    let image: UIImage?
    
    init(name: String) {
        self.name = name
        self.image = nil
    }
}

enum ELListItem: Hashable {
    case header(ELHeaderItem)
    case symbol(ELSymbolItem)
}

import UIKit

class ExpandableListViewController: UIViewController {
    //MARK: - Properties
    let modelObjcet = [
        ELHeaderItem(title: "Test title 1", symbols: [
            ELSymbolItem(name: "Symbol 1"),
            ELSymbolItem(name: "Symbol 2"),
            ELSymbolItem(name: "Symbol 3"),
            ELSymbolItem(name: "Symbol 4"),
            ELSymbolItem(name: "Symbol 5")
        ]),
        
        ELHeaderItem(title: "Test title 2", symbols: [
            ELSymbolItem(name: "Symbol 1"),
            ELSymbolItem(name: "Symbol 2"),
        ]),
        
        ELHeaderItem(title: "Test title 3", symbols: [
            ELSymbolItem(name: "Symbol 1"),
            ELSymbolItem(name: "Symbol 2"),
            ELSymbolItem(name: "Symbol 3"),
            ELSymbolItem(name: "Symbol 4"),
            ELSymbolItem(name: "Symbol 5"),
            ELSymbolItem(name: "Symbol 6"),
            ELSymbolItem(name: "Symbol 7")
        ])
        
    ]
    
//    private var collectionView: UICollectionView = {
//       let layoutConfig = UICollectionLayoutList
//    }()
    //MARK: - Init
    //MARK: - Func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}
