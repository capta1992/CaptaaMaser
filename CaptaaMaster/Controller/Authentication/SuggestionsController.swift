//
//  SuggestionsController.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 4/30/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

private let reusueIdentifier = "SuggestionsCell"

class SuggestionsController: UIViewController {
    
    // MARK: - Properties
    
    private var users = [User]() {
        didSet { searchTableView.reloadData()}
    }
    
    
    
    
    lazy var searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    
    
    
    private let iconImage = UIImageView(image: #imageLiteral(resourceName: "captaalogo"))
    private let dividerView = SeperatorView()
    private let dividerView2 = SeperatorView()
    private let dividerView3 = SeperatorView()
    
    
    private let suggestionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Suggestions for you to follow"
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-Bold", size: 24)
        return label
    }()
    
    private let suggestionInstructionLabel: UILabel = {
        let label = UILabel()
        label.text = "When you follow someone, you'll see their Captions in your Home Timeline."
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        return label
    }()
    
    
    private let interestedLabel: UILabel = {
         let label = UILabel()
         label.text = "You may be interested in"
         label.textColor = .white
         label.font = UIFont(name: "AvenirNext-Bold", size: 18)
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
        fetchUsers()
        
        
        
    }
    
    
    // MARK: - API
    
    func fetchUsers() {
        UserService.shared.fetchUsers { (users) in
            users.forEach { (user) in
                self.users = users
            }
        }
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
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(SuggestionsCell.self, forCellReuseIdentifier: reusueIdentifier)
        
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
        
        view.addSubview(searchTableView)
        searchTableView.anchor(top: dividerView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: -450)
        
        searchTableView.rowHeight = 90
        searchTableView.separatorStyle = .none
        
        
        
        view.addSubview(actionButton)
        actionButton.anchor(top: view.topAnchor, left: nil, right: view.rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 8)
        
        
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


extension SuggestionsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: reusueIdentifier, for: indexPath) as! SuggestionsCell
        
        cell.user = users[indexPath.row]
        return cell
    }
    
    
}
