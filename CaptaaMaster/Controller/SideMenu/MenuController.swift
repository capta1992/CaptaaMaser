//
//  MenuController.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/11/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

protocol MenuControllerDelegate: class {
    func didSelect(option: MenuOptions)
}

enum MenuOptions: Int, CustomStringConvertible, CaseIterable {
    case profile
    case contact
    case logout
    
    var description: String {
        switch self {
        case .profile: return "Edit Profile"
        case .contact: return "Contact Us"
        case .logout: return "Logout"
        }
    }
    
    var image: UIImage {
        switch self {
        case .profile: return #imageLiteral(resourceName: "ic_person_outline_white_2x-1")
        case .contact: return #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        case .logout: return #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        }
    }
}

private let reuseIdentifer = "MenuOptionCell"

class MenuController: UITableViewController {
    
    // MARK: - Properties
    
    private var user: User
    weak var delegate: MenuControllerDelegate?
    
    private lazy var headerView: MenuHeader = {
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 80, height: 180)
        let view = MenuHeader(frame: frame)
        view.user = user
        return view
    }()
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(style: .plain)
    }
    
  
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .instagramColor
        
        
        tableView.register(MenuOptionCell.self, forCellReuseIdentifier: reuseIdentifer)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .instagramColor
        tableView.separatorStyle = .none
        tableView.rowHeight = 72
        tableView.tableHeaderView = headerView
        
    }
}

// MARK: - UITableViewDelegate/DataSource

extension MenuController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! MenuOptionCell
        let option = MenuOptions(rawValue: indexPath.row)
        cell.option = option
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let option = MenuOptions(rawValue: indexPath.row) else { return }
        delegate?.didSelect(option: option)
    }
}
