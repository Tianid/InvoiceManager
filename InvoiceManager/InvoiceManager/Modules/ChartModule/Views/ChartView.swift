//
//  ChartView.swift
//  InvoiceManager
//
//  Created by Tianid on 12.10.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

import UIKit

class ChartView: UIView {
    //MARK: - Properties
    var presenter: IChartPresenter?
    
    private let cellIdentifier = "cellIdentifier"
    private var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collection.isPagingEnabled = true
        collection.backgroundColor = .clear
        return collection
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        configureConstraints()
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Func
    
    private func configureConstraints() {
        addSubview(collectionView)
        collectionView.anchor(top: safeAreaLayoutGuide.topAnchor,
                              leading: safeAreaLayoutGuide.leadingAnchor,
                              bottom: safeAreaLayoutGuide.bottomAnchor,
                              trailing: safeAreaLayoutGuide.trailingAnchor)
        
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ChartViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }

}

extension ChartView: UICollectionViewDelegate {
    
}

extension ChartView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.model.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ChartViewCell else { return UICollectionViewCell() }
        let preparedCell = presenter?.prepareCollectionViewCell(cell: cell, index: indexPath.row)
        
        return preparedCell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ChartViewCell else { return }
        cell.updateCharts()
    }
}

extension ChartView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
        
        let referenceWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
            - sectionInset.left
            - sectionInset.right
            - collectionView.contentInset.left
            - collectionView.contentInset.right
        
        let referenceHeight = collectionView.safeAreaLayoutGuide.layoutFrame.height
            - sectionInset.top
            - sectionInset.bottom
            - collectionView.contentInset.top
            - collectionView.contentInset.bottom
        
        return CGSize(width: referenceWidth - 6, height: referenceHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}
