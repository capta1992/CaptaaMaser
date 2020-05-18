//
//  Extensions.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 4/28/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//


import UIKit
import JGProgressHUD
import Firebase
import Photos


struct Fonts {
    static let captionFont = "AmaticSC"
}
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    static let twitterBlue = UIColor.rgb(red: 29, green: 161, blue: 242)
    static let backgroundColor = UIColor.rgb(red: 25, green: 25, blue: 25)
    static let wedjColor = UIColor.rgb(red: 61, green: 89, blue: 115)
    static let darkBlueMode = UIColor.rgb(red: 36, green: 52, blue: 71)
    static let mainBlueTint = UIColor.rgb(red: 17, green: 154, blue: 237)
    static let instagramColor = UIColor.rgb(red: 253, green: 29, blue: 29)
    
    
}


extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor, let padding = paddingTop {
            self.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        }
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
                 paddingLeft: CGFloat = 0, constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        
        if let left = leftAnchor {
            anchor(left: left, paddingLeft: paddingLeft)
        }
    }
    
    func center(inView view: UIView, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }
    
    func setDimensions(height: CGFloat, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setHeight(height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    
    func pulse(withIntensity intensity: CGFloat, withDuration duration: Double, loop: Bool) {
        UIView.animate(withDuration: duration, delay: 0, options: [.repeat, .autoreverse], animations: {
            loop ? nil : UIView.setAnimationRepeatCount(1)
            self.transform = CGAffineTransform(scaleX: intensity, y: intensity)
        }) { (true) in
            self.transform = CGAffineTransform.identity
        }
    }
    
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color
        switch side {
        case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }
        layer.addSublayer(border)
    }
    
    
    func addConstraintsToFillView(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: view.topAnchor, left: view.leftAnchor,
               bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    
    func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superviewTopAnchor = superview?.topAnchor,
            let superviewBottomAnchor = superview?.bottomAnchor,
            let superviewLeadingAnchor = superview?.leftAnchor,
            let superviewTrailingAnchor = superview?.rightAnchor else { return }
        
        anchor(top: superviewTopAnchor, left: superviewLeadingAnchor,
               bottom: superviewBottomAnchor, right: superviewTrailingAnchor)
    }
}






extension UIViewController {
    static let hud = JGProgressHUD(style: .dark)
    
    
    func configureGradientBackground() {
        let gradient = CAGradientLayer()
        // experiment and change colors
        gradient.colors = [UIColor.backgroundColor.cgColor, UIColor.backgroundColor.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
        
        
    }
    
    func showLoader(_ show: Bool) {
        view.endEditing(true)
        
        if show {
            UIViewController.hud.show(in: view)
        } else {
            UIViewController.hud.dismiss()
        }
    }
    
    func showMessage(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

extension UITextField {
    func addButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        doneToolbar.backgroundColor = .twitterBlue
        doneToolbar.barTintColor = .backgroundColor
        self.inputAccessoryView = doneToolbar
        
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}

extension UIView {
    func bindToKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    
    @objc func keyboardWillChange(_ notification: NSNotification) {
        
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let beginningFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = endFrame.origin.y - beginningFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
              self.frame.origin.y += deltaY
          }, completion: nil)
        
    }
}

extension UIView {

func inputContainerView(image: UIImage, textField: UITextField? = nil,
                        segmentedControl: UISegmentedControl? = nil) -> UIView {
    let view = UIView()
    let imageView = UIImageView()
    imageView.image = image
    imageView.alpha = 0.87
    view.addSubview(imageView)
    
    
    if let textField = textField {
        imageView.centerY(inView: view)
        imageView.anchor(left: view.leftAnchor, paddingLeft: 8, width: 24, height: 24)
        
        view.addSubview(textField)
        textField.centerY(inView: view)
        textField.anchor(left: imageView.rightAnchor, bottom: view.bottomAnchor,
                         right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
    }
    
    if let sc = segmentedControl {
        imageView.anchor(top: view.topAnchor, left: view.leftAnchor,
                         paddingTop: -8, paddingLeft: 8, width: 24, height: 24)
    
        
        view.addSubview(sc)
        sc.anchor(left: view.leftAnchor, right: view.rightAnchor,
                 paddingLeft: 8, paddingRight: 8)
        sc.centerY(inView: view, constant: 16)
    
    }
    
    let separatorView = UIView()
    separatorView.backgroundColor = .lightGray
    view.addSubview(separatorView)
    separatorView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor,
                         right: view.rightAnchor, paddingLeft: 8, height: 0.75)
    
    separatorView.isHidden = true
    return view
}

}

extension UIButton {
    func selectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    }
    func deselectedColor() {
        self.backgroundColor = .twitterBlue
    }
    
}

extension Database {
    static func fetchUser(with uid: String, completion: @escaping(User)-> ()) {
        REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else {return}
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
        }
        
}

}


extension UIViewController: FeedShareDelegate {
    
    func postImageToInstagram(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            if error != nil {
                print(error)
            }

            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

            let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)

       
//            guard let urlScheme = URL(string: "instagram"),
//                let imageData = image.pngData() else {
//                return
//            }
//
//            if UIApplication.shared.canOpenURL(urlScheme) {
//                let pasterboardItems = [["com.instagram.sharedSticker.stickImage": imageData]]
//                let pasterboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60*5)]
//
//                UIPasteboard.general.setItems(pasterboardItems, options: pasterboardOptions)
//
//                UIApplication.shared.open(urlScheme, options: [:], completionHandler: nil)
//            }
        
            if let lastAsset = fetchResult.firstObject {
                let localIdentifier = lastAsset.localIdentifier
                let u = "instagram://library?AssetPath=" + localIdentifier
                let url = URL(string: u)!
                if UIApplication.shared.canOpenURL(url) {
                    guard let imageData = image.pngData() else {
                        return
                    }
                     let pasterboardItems = [["com.instagram.sharedSticker.stickerImage": imageData]]
                                    let pasterboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60*5)]
                    UIPasteboard.general.setItems(pasterboardItems, options: pasterboardOptions)
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    let alertController = UIAlertController(title: "Error", message: "Instagram is not installed", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
    }
}





