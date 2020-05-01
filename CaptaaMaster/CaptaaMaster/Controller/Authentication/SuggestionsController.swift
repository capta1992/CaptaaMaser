//
//  SuggestionsController.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 4/30/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

class SuggestionsController: UIViewController {
    
    // MARK: - Properties
    
    private let iconImage = UIImageView(image: #imageLiteral(resourceName: "captaalogo"))
    private let dividerView = SeperatorView()
    private let dividerView2 = SeperatorView()
    private let dividerView3 = SeperatorView()
    
    
    private let suggestionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Suggestions for you to follow"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    
    private let suggestionInstructionLabel: UILabel = {
        let label = UILabel()
        label.text = "When you follow someone, you'll see their Captions in your Home Timeline."
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    
    private let interestedLabel: UILabel = {
         let label = UILabel()
         label.text = "You may be interested in"
         label.textColor = .white
         label.font = UIFont.boldSystemFont(ofSize: 18)
         return label
        
    }()
    
    
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        //  button.addTarget(self, action: #selector(showSuggestionController), for: .touchUpInside)
        return button
    }()
    
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        
        
        
    }
    
    // MARK: - Selectors
    
    
    func configureNavigationUI() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
    }
    
    
    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .backgroundColor
        configureNavigationUI()
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0)
        
        iconImage.setDimensions(height: 25, width: 25)
        iconImage.clipsToBounds = true
        iconImage.contentMode = .scaleAspectFit
        
        view.addSubview(suggestionsLabel)
        suggestionsLabel.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, paddingTop: 35, paddingLeft: 8)
        
        view.addSubview(suggestionInstructionLabel)
        suggestionInstructionLabel.anchor(top: suggestionsLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 8)
        
        view.addSubview(dividerView2)
        dividerView2.anchor(top: suggestionInstructionLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 12)
        
        view.addSubview(interestedLabel)
        interestedLabel.anchor(top: dividerView2.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 12, paddingLeft: 8)
        
        view.addSubview(dividerView3)
        dividerView3.anchor(top: interestedLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 12)
        
        
        
        
        
        
        view.addSubview(dividerView)
        dividerView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 100, paddingRight: 0 )
        
        view.addSubview(actionButton)
        actionButton.anchor(top: dividerView.bottomAnchor, left: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 8)
        
        
        actionButton.backgroundColor = .twitterBlue
        actionButton.setTitle("Next", for: .normal)
        actionButton.titleLabel?.textAlignment = .center
        actionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        actionButton.setDimensions(height: 32, width: 64)
        actionButton.layer.cornerRadius = 32 / 2
        
        actionButton.bindToKeyboard()
        dividerView.bindToKeyboard()
        
        
    }
    
    
}
