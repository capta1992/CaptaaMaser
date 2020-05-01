//
//  AuthentificationViewModel.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 4/29/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

protocol AuthenticationViewmodel {
    var formIsValid: Bool {get}
    var shouldEnableButton: Bool {get}
    var buttonTitleColor: UIColor {get}
    var buttonBackgroundColor: UIColor {get}
    
}

protocol FormViewModel {
    func upadateForm()
}

struct LoginViewModel: AuthenticationViewmodel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false &&
            password?.isEmpty == false
    }
    
    var shouldEnableButton: Bool {
        return formIsValid
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
    
    var buttonBackgroundColor: UIColor {
        let enabledBlue = UIColor.twitterBlue
        let diabledBlue = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1).withAlphaComponent(0.5)
        return formIsValid ? enabledBlue : diabledBlue
    }
    
    
}

struct RegistrationViewModel: AuthenticationViewmodel {
    
    var email: String?
    var name: String?
    
    
    var formIsValid: Bool {
        return email?.isEmpty == false &&
            name?.isEmpty == false    }
    
    var shouldEnableButton: Bool {
        return formIsValid
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
    
    var buttonBackgroundColor: UIColor {
        let enabledBlue = UIColor.twitterBlue
        let diabledBlue = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1).withAlphaComponent(0.5)
        return formIsValid ? enabledBlue : diabledBlue
    }
    
}

struct ResetPasswordViewModel: AuthenticationViewmodel {
    
    var email: String?
    
    
    var formIsValid: Bool {
        return email?.isEmpty == false
    }
    
    var shouldEnableButton: Bool {
        return formIsValid
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
    
    var buttonBackgroundColor: UIColor {
        let enabledBlue = UIColor.mainBlueTint
        let diabledBlue = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1).withAlphaComponent(0.5)
        return formIsValid ? enabledBlue : diabledBlue
        
    }
}
