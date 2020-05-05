//
//  FeedController.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 4/29/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "CaptionCell"
private let categoryIdentifier = "Category Cell"

class FeedController: BaseViewController {
    
    // MARK: - Properties
    
    private var captions = [Caption]() {
        didSet {captionCollectionView.reloadData()}
    }
    
    private let logoImageView: UIImageView  = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "captaalogo")
        view.setDimensions(height: 28, width: 28)
        return view
    }()
    
    lazy var captionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collection.backgroundColor = .white
        layout.scrollDirection = .vertical
        collection.isScrollEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
      lazy var categoryCollectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
          collection.backgroundColor = .twitterBlue
          layout.scrollDirection = .horizontal
          collection.isScrollEnabled = true
          collection.showsHorizontalScrollIndicator = false
          collection.translatesAutoresizingMaskIntoConstraints = false
          return collection
      }()
    
    

    
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureUI()
        
    }
    
    // MARK: - API
    
    
    // YOU MUST CHANGE THIS TO ONLY FETCH TWEETS THAT THE USER IS FOLLOWING
    func fetchCaptions() {
        CaptionService.shared.fetchSavedCaptions { (captions) in
            self.captions = captions
        }
    }
    
    
    // MARK: - Selectors
    
    
    
    
    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.setDimensions(height: 25, width: 25)
        navigationItem.titleView = logoImageView
        
        
        
        configureRightBarButton()
        fetchCaptions()
        
        captionCollectionView.delegate = self
        captionCollectionView.dataSource = self
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        view.addSubview(captionCollectionView)
        captionCollectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor ,right: view.rightAnchor, paddingTop: 150)
        
        
        categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: categoryIdentifier)
        captionCollectionView.register(CaptionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        view.addSubview(categoryCollectionView)
        categoryCollectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 80, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        
        view.addSubview(captionCollectionView)
        captionCollectionView.anchor(top: categoryCollectionView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 150)
        
        
        
    }
    
    func configureRightBarButton() {
        let contactButton = UIButton()
        contactButton.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
        contactButton.setDimensions(height: 20, width: 20)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: contactButton)
        
    }
    
}




// You made your code a little bit different than stephan you created your own collecttion view(delete when app is complete)
// MARK: - UICollectionViewDelegate/Datasource/Delegate



extension FeedController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.categoryCollectionView{
            return 5
        } else {
            return captions.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.categoryCollectionView {
            let cellA = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: categoryIdentifier, for: indexPath) as! CategoryCell
            
            
            return cellA
        } else {
            let cellB = captionCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CaptionCell
            
            
            return cellB
            
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 520)
    }
}


extension FeedController: CapttionCellDelegate {
    func handleProfileImageTapped(_ cell: CaptionCell) {
        let controller = ProfileController(collectionViewLayout: UICollectionViewFlowLayout()) 
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}


 // func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 //     return CGSize(width: view.frame.width, height: 520)
      
//  }


