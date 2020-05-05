//
//  RegistrationController.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 4/28/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit
import Firebase


class RegistrationController: UIViewController, UITextFieldDelegate {
    
    
    var user: User!
    
    // MARKS: - Properties
    
    private let dividerView = SeperatorView()
    private let iconImage = UIImageView(image: #imageLiteral(resourceName: "captaalogo"))
    private var viewModel = RegistrationViewModel()
    
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handlePassword), for: .touchUpInside)
        return button
    }()
    
    private let createAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Create your account"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    
    
    private lazy var emailContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let view = Utilities().inputContainerView(withImage: image, textField: emailTextField)
        return view
    }()
    
    private lazy var nameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_person_outline_white_2x-1")
        let view = Utilities().inputContainerView(withImage: image, textField: nameTextField)
        return view
    }()
    
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "Email")
        return tf
    }()
    
    private let nameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "Name")
        
        return tf
    }()
    
    private lazy var accountTypeContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_account_box_white_2x"),
                                               segmentedControl: accountTypeSegmentedControl)
        view.heightAnchor.constraint(equalToConstant: 80).isActive = true
        return view
    }()
    
    
    
    private let accountTypeSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Personal", "Buisness"])
        sc.backgroundColor = .backgroundColor
        sc.tintColor = UIColor(white: 1, alpha: 0.87)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Log In", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        button.addTarget(self, action: #selector(showLogincontroller), for: .touchUpInside)
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    
    
    
    // MARKS: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNotificationObservor()
        
        
    }
    
    
    // MARK: - Selectors
    
    @objc func showLogincontroller() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func handleKeyboardDismiss() {
        view.endEditing(true)
    }
    
    
    
    @objc func handlePassword() {
        guard let email = emailTextField.text else {return}
        guard let name = nameTextField.text else {return}
        
        let dic = [
            "email": email,
            "fullname": name
            ] as [String: AnyObject]
        
        
        self.user = User(uid: "", dictionary: dic)
        
        let controller = PasswordController()
        controller.user = self.user
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
    @objc func textDidChange(_ sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.name = sender.text
        }
        
        upadateForm()
        
    }
    
    
    
    func configureNavigationUI() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
    }
    
    
    
    // MARK: - Halpers
    
    
    func configureNotificationObservor() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
    }
    
    func configureUI() {
        view.backgroundColor = .backgroundColor
        configureNavigationUI()
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0)
        
        iconImage.setDimensions(height: 25, width: 25)
        iconImage.clipsToBounds = true
        iconImage.contentMode = .scaleAspectFit
        
        let secondStack = UIStackView(arrangedSubviews: [createAccountLabel,emailContainerView, nameContainerView, accountTypeContainerView])
        secondStack.axis = .vertical
        secondStack.spacing = 20
        secondStack.distribution = .fillEqually
        
        view.addSubview(secondStack)
        secondStack.anchor(top: iconImage.bottomAnchor,left: view.leftAnchor, bottom: nil, right: view.rightAnchor,paddingTop: 20, paddingLeft: 32, paddingRight: 32)
        
        
        
        actionButton.backgroundColor = .twitterBlue
        actionButton.setTitle("Next", for: .normal)
        actionButton.titleLabel?.textAlignment = .center
        actionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        actionButton.setDimensions(height: 32, width: 64)
        actionButton.layer.cornerRadius = 32 / 2
        
        view.addSubview(dividerView)
        dividerView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 100, paddingRight: 0 )
        
        view.addSubview(actionButton)
        actionButton.anchor(top: dividerView.bottomAnchor, left: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 8)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(top: dividerView.bottomAnchor, left: view.leftAnchor, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 8)
        
        actionButton.bindToKeyboard()
        alreadyHaveAccountButton.bindToKeyboard()
        dividerView.bindToKeyboard()
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleKeyboardDismiss))
        view.addGestureRecognizer(tap)
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            
            return true
            
        }
        
        
    }
}

// MARK: - Formviewmodel

extension RegistrationController: FormViewModel {
    func upadateForm() {
        actionButton.isEnabled = viewModel.shouldEnableButton
        actionButton.backgroundColor = viewModel.buttonBackgroundColor
        actionButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
    }
    
}
