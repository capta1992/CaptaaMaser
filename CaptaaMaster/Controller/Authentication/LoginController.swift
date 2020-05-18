//
//  LoginController.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 4/28/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit
import GoogleSignIn


protocol AuthenticationDelegate: class {
    func authenticationComplete()
}

class LoginController: UIViewController, UITextFieldDelegate{
    
    
    // MARK: - Properties
    
    weak var delegate: AuthenticationDelegate?
    
    private var viewModel = LoginViewModel()
    
    private let iconImage = UIImageView(image: #imageLiteral(resourceName: "captaalogo"))
    
    private lazy var emailContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: passwordTextField)
        return view
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "Email")
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.87),
                                                   .font: UIFont.systemFont(ofSize: 14)]
        let attributedTitle = NSMutableAttributedString(string: "Forgot your password? ", attributes: atts)
        
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.87),.font: UIFont.boldSystemFont(ofSize: 14)]
        
        attributedTitle.append(NSAttributedString(string: "Get help signing in", attributes: boldAtts))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
        
        return button
    }()
    
    private let dividerView = DividerView()
    
    private let googleLoginButon: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "btn_google_light_pressed_ios").withRenderingMode(.alwaysOriginal), for: .normal )
        button.setTitle(" Log in with Google", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleGoogleLogin), for: .touchUpInside)
        return button
    }()
    
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNotificationObservor()
        configureGoogleLogin()
        
        emailTextField.addButtonOnKeyboard()
        passwordTextField.addButtonOnKeyboard()
        
    }
    
    // MARK: - API
    
    
    func configureGoogleLogin() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    // MARK: - Selectors
    
    @objc func handleKeyboardDismiss() {
        view.endEditing(true)
    }
    
    
    
    
    @objc func handleSignup() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    @objc func textDidChange(_ sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        
        upadateForm()
    }
    

    @objc func handleGoogleLogin() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @objc func handleLogin() {
        
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        showLoader(true)
        
        AuthService.shared.logUserIn(withEmail: email, password: password) { (result, error) in
                self.showLoader(false)
            if let error = error {
                self.showMessage(withTitle: "Error", message: error.localizedDescription)
                return
            }
            
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow}) else {return}
            guard let tab = window.rootViewController as? MainTabController else {return}
            
            self.showLoader(false)
            tab.authenticateUserAndConfigureUI()
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    
    
    @objc func handleForgotPassword() {
        let controller = ResetPasswordController()
        controller.email = emailTextField.text
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    
    
    // MARK: - Helpers
    
    func configureNotificationObservor() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
    }
    
    func configureUI() {
        view.backgroundColor = .backgroundColor
        configureNavigationUI()
        
        
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 120, width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        iconImage.setDimensions(height: 40, width: 40)
        iconImage.clipsToBounds = true
        iconImage.contentMode = .scaleAspectFit
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,paddingTop: 20, paddingLeft: 32, paddingRight: 32)
        
        
        let secondStack = UIStackView(arrangedSubviews: [forgotPasswordButton, dividerView, googleLoginButon])
        
        secondStack.axis = .vertical
        secondStack.spacing = 28
        
        view.addSubview(secondStack)
        secondStack.anchor(top: stack.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingRight: 32)
        
        
        
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleKeyboardDismiss))
        view.addGestureRecognizer(tap)
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            
            return true
        }
        
    }
    func configureNavigationUI() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
    }
}

// MARK: - Formviewmodel

extension LoginController: FormViewModel {
    func upadateForm() {
        loginButton.isEnabled = viewModel.shouldEnableButton
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
    }
    
}

// MARK: - GIDSignInDelegate

extension LoginController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        Service.signInWithGoogle(didSignInFor: user) { (error, ref) in
            print("DEBUG: Successfully signed in wih google")
            self.delegate?.authenticationComplete()
        }
    }
}

// MARK: - ResetPassswordControllerDelegate

extension LoginController: ResetPassswordControllerDelegate {
    func didSendResetPasswordLink() {
        navigationController?.popViewController(animated: true)
        self.showMessage(withTitle: "Success", message: MSG_RESET_PASSWORD_LINK_SENT)
    }

}







