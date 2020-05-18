//
//  ExploreController.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 4/29/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//


import UIKit
import SDWebImage
import Firebase

private let reuseIdenttifier = "ExploreCell"

class ExploreController: BaseViewController {
    
    // MARK: - Properties
    
    
    private let filterBar = ExploreFilterView()
    
    private var selectedFilter: ExploreFilterOptions = .music {
        didSet { searchTableView.reloadData()}
    }
    
    private var musicUsers = [User]()
    private var categoryUsers = [User]()
    private var featuredUsers = [User]()
    
    
    
    private var currentDataSource: [User] {
        switch selectedFilter {
        case.music: return musicUsers
        case.categories: return categoryUsers
        case.featured: return featuredUsers
        }
    }
    
    private var filteredUsers = [User]() {
        didSet { searchTableView.reloadData()}
    }
    
    private var inSearchMode: Bool {
        return searchController.isActive &&
            !searchController.searchBar.text!.isEmpty
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    
    lazy var searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureUI()
        fetchMusicUsers()
        fetchCategoryUsers()
        fetchFeaturedUsers()
        configureSearchController()
        
    }
    
    // MARK: - API
    
    func fetchMusicUsers() {
        Database.database().reference().child("music").observe(.childAdded) { (snapshot) in
            // uid
            let uid = snapshot.key
            
            Database.fetchUser(with: uid, completion: { (user) in
                self.musicUsers.append(user)
                self.searchTableView.reloadData()
            })
            
        }
    }
    
    
    func fetchCategoryUsers() {
        Database.database().reference().child("categories").observe(.childAdded) { (snapshot) in
            // uid
            let uid = snapshot.key
            
            Database.fetchUser(with: uid, completion: { (user) in
                self.categoryUsers.append(user)
                self.searchTableView.reloadData()
            })
            
        }
    }
    
    
    func fetchFeaturedUsers() {
        Database.database().reference().child("featured").observe(.childAdded) { (snapshot) in
            // uid
            let uid = snapshot.key
            
            Database.fetchUser(with: uid, completion: { (user) in
                self.featuredUsers.append(user)
                self.searchTableView.reloadData()
            })
            
        }
    }
    
    
    // MARK: - Selectors
    

    
    
    
    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        
        
        guard let tabHeight = tabBarController?.tabBar.frame.height else { return}
        searchTableView.contentInset.bottom = tabHeight
        
        filterBar.delegate = self
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        searchTableView.register(ExploreCell.self, forCellReuseIdentifier: reuseIdenttifier)
        
        
        view.addSubview(filterBar)
        filterBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right:  view.rightAnchor, height: 50)
        
        
        view.addSubview(searchTableView)
        searchTableView.anchor(top: filterBar.bottomAnchor,left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        searchTableView.rowHeight = 90
        searchTableView.separatorStyle = .none
        
        
        navigationItem.title = "Explore"
        
        let profileImageView = UIImageView()
        profileImageView.setDimensions(height: 32, width: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
        
      
             
        
        
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchBar.placeholder = "Search for a artist"
        navigationItem.searchController = searchController
        definesPresentationContext = false
        
    }
    
    
}

extension ExploreController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filteredUsers.count : currentDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: reuseIdenttifier, for: indexPath) as! ExploreCell
        
        let user = inSearchMode ? filteredUsers[indexPath.row] : currentDataSource[indexPath.row]
        cell.user = user
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = inSearchMode ? filteredUsers[indexPath.row] : currentDataSource[indexPath.row]
        let controller = MusicProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}

extension ExploreController: ExploreFilterViewDelegate {
    func filterView(_ view: ExploreFilterView, didSelect index: Int) {
        
        guard let filter = ExploreFilterOptions(rawValue: index) else { return}
        self.selectedFilter = filter
        
    }
    
}

extension ExploreController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return}
        
        filteredUsers = currentDataSource.filter({($0.fullname?.contains(searchText))!})
        
    }
    
    
}
