//
//  ResetPasswordController.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/1/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

protocol ResetPassswordControllerDelegate: class {
    func didSendResetPasswordLink()
}

class ResetPasswordController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = ResetPasswordViewModel()
    weak var delegate: ResetPassswordControllerDelegate?
    var email: String?
    
    
    private let iconImage = UIImageView(image: #imageLiteral(resourceName: "captaalogo"))
    private let emailTextField = CustomTexttField(placeHolder: "Email")
    
    private let resetPasswordButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.title = "Send Reset Link"
        button.addTarget(self, action: #selector(handleResetPassword), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        return button
    }()
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNotificationObservor()
        loadEmail()
        
    }
    
    
    // MARK: - Selectors
    
    @objc func handleResetPassword() {
        guard let email = viewModel.email else {return}
        
        showLoader(true)
        
        Service.resetPassword(forEmail: email) { (error) in
            self.showLoader(false)
            if let error = error {
                self.showMessage(withTitle: "Error", message: error.localizedDescription)
                return
            }
            
            self.delegate?.didSendResetPasswordLink()
        }
    }
    
    @objc func handleDismissal() {
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @objc func textDidChange(_ sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
            
        }
        
        upadateForm()
        
        
    }
    
    
    
    
    // MARK: - Helpers
    
    func configureUI() {
        
        configureGradientBackground()
        
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 120, width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        iconImage.setDimensions(height: 40, width: 40)
        iconImage.clipsToBounds = true
        iconImage.contentMode = .scaleAspectFit
        
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, resetPasswordButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
    }
    
    func loadEmail() {
        guard let email = email else {return}
        viewModel.email = email
        
        emailTextField.text = email
        upadateForm()
    }
    
    func configureNotificationObservor() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
    }
}


// MARK: - Formviewmodel

extension ResetPasswordController: FormViewModel {
    func upadateForm() {
        resetPasswordButton.isEnabled = viewModel.shouldEnableButton
        resetPasswordButton.backgroundColor = viewModel.buttonBackgroundColor
        resetPasswordButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
    }
}

