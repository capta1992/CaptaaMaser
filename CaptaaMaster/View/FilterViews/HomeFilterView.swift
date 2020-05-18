//
//  HomeFilterView.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/9/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

private let reuseIdenttifier = "HomeFilterCell"

protocol HomeFilterViewDelegate: class {
    func filterView(_ view: HomeFilterView, didSelect indexpath: IndexPath)
}

class HomeFilterView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: HomeFilterViewDelegate?
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    
    
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        collectionView.register(HomeFilterCell.self, forCellWithReuseIdentifier: reuseIdenttifier)
        addSubview(collectionView)
        collectionView.addConstraintsToFillView(self)
        
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .left)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
}

// MARK: - UICollectionViewDataSource

extension HomeFilterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdenttifier, for: indexPath) as! HomeFilterCell
        
        let option = HomeFilterOptions(rawValue: indexPath.row)
        cell.option = option
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension HomeFilterView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.filterView(self, didSelect: indexPath)
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension HomeFilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 3, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}



