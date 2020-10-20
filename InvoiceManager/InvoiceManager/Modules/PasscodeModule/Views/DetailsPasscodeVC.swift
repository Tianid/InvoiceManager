//
//  DetailsPasscodeVC.swift
//  InvoiceManager
//
//  Created by Tianid on 20.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class DetailsPasscodeVC: UIViewController {
    //MARK: - Properties

    private var pageControl: UIPageControl = {
        let pageContorl = UIPageControl()
        pageContorl.numberOfPages = 6
        return pageContorl
    }()
    
    private var testButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("TEST", for: .normal)
        button.addTarget(self, action: #selector(test), for: .touchUpInside)
        return button
    }()
    
     //MARK: - Init
     //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(pageControl)
        view.addSubview(testButton)
        pageControl.anchor(centerX: view.centerXAnchor,
                           centerY: view.centerYAnchor)
        
        testButton.anchor(top: pageControl.bottomAnchor,
                          leading: pageControl.leadingAnchor,
                          trailing: pageControl.trailingAnchor)

        // Do any additional setup after loading the view.
    }
    
    @objc func test() {
        pageControl.currentPage += 1
    }
}
