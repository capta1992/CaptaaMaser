//
//  PasswordController.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 4/29/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit
import Firebase

class PasswordController: UIViewController {
    
    // MARK: - Properties
    
    private let iconImage = UIImageView(image: #imageLiteral(resourceName: "captaalogo"))
    private let dividerView = SeperatorView()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "You'll need a password"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    
    private let passwordInstructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Make sure it's 6 characters or more."
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: passwordTextField)
        return view
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(showProfilePictureController), for: .touchUpInside)
        return button
    }()
    
    private let goBackButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Go Back", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        
        button.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleKeyboardDismiss() {
        view.endEditing(true)
    }
    
    @objc func handleGoBack() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func showProfilePictureController() {
    
    guard let username = passwordTextField.text else {return}

        Service.registerUserWithFirebase(withEmail: "", password: "", fullname: username) { (error, ref) in
            if let error = error {
                print("DEBUG \(error.localizedDescription)")
                return
            }
        }
        
        
        let controller = ProfilePictureController()
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
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
        
        
        view.addSubview(passwordLabel)
        passwordLabel.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, paddingTop: 35, paddingLeft: 8)
        
        view.addSubview(passwordInstructionLabel)
        passwordInstructionLabel.anchor(top: passwordLabel.bottomAnchor, left: view.leftAnchor, paddingTop: 15, paddingLeft: 8)
        
        view.addSubview(passwordContainerView)
        passwordContainerView.anchor(top: passwordInstructionLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 25, paddingLeft: 8)
       
        view.addSubview(dividerView)
        dividerView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 100, paddingRight: 0 )
        
        view.addSubview(actionButton)
        actionButton.anchor(top: dividerView.bottomAnchor, left: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 8)
        
        view.addSubview(goBackButton)
        goBackButton.anchor(top: dividerView.bottomAnchor, left: view.leftAnchor, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 8)
        
        
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
        goBackButton.bindToKeyboard()
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleKeyboardDismiss))
        view.addGestureRecognizer(tap)
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            
            return true
            
        }
    }
    
}
