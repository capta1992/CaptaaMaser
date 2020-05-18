//
//  ControlFilterView.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/7/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ExploreFilterCell"

protocol ExploreFilterViewDelegate: class {
    func filterView(_ view: ExploreFilterView, didSelect index: Int)
}

class ExploreFilterView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: ExploreFilterViewDelegate?
    
    lazy var collecttionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    private let underineView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        return view
    }()
    
    
    
    
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        collecttionView.register(ExploreFilterCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        collecttionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .left)
        
        addSubview(collecttionView)
        collecttionView.addConstraintsToFillView(self)
        
        
    }
    
    override func layoutSubviews() {
        
        addSubview(underineView)
        underineView.anchor(left: leftAnchor, bottom: bottomAnchor,
                            width: frame.width / 3, height: 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
    
}


extension ExploreFilterView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ExploreFilterOptions.allCases.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ExploreFilterCell
        
        let option = ExploreFilterOptions(rawValue: indexPath.row)
        cell.option = option
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        let xPosition = cell?.frame.origin.x ?? 0
        
        
        UIView.animate(withDuration: 0.3) {
            self.underineView.frame.origin.x = xPosition
        }
        
        delegate?.filterView(self, didSelect: indexPath.row)
    }
    
    
}

extension ExploreFilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 3, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}




