//
//  CaptionViewModel.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/3/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

struct CaptionViewModel {
    
    let caption: Caption
    let user: User
    
    var profileImageUrl: URL? {
        return user.profileImageUrl
    }
    
    var timeStamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: caption.timestamp, to: now) ?? "2m"
    }
    
    
    var headerTimeStamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a · MM/dd/yyyy"
        return formatter.string(from: caption.timestamp)
    }
    

    
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullname!, attributes: [.font: UIFont(name: "AvenirNext-Bold", size: 12) as Any])
        
        
        title.append(NSAttributedString(string: " · \(timeStamp)",
            attributes: [.font: UIFont(name: "AvenirNext-Medium", size: 10) as Any,
                     .foregroundColor: UIColor.lightGray]))
        
        
        return title
        
    
    }
    
    
      var likesString: NSAttributedString? {
          return attributedText(withValue: user.stats?.following ?? 0, text: "Copy", valueColor: .instagramColor, textColor: .black)
          
      }
      
      var copyString: NSAttributedString {
          return attributedText(withValue: user.stats?.followers ?? 0, text: "Likes", valueColor: .instagramColor, textColor: .black)
      }
    
    
    var likeButtonTintColor: UIColor {
        return caption.didLike ? .red: .lightGray
    }
    
    var likeButtonImage: UIImage {
        let imageName = caption.didLike ? "like_filled" : "like"
        return UIImage(named: imageName)!
    }
    
    
    init(caption: Caption) {
        self.caption = caption
        self.user = caption.user
    }
    
    fileprivate func attributedText(withValue value: Int, text: String,
                                    valueColor: UIColor, textColor: UIColor) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(value)",
            attributes: [.font : UIFont(name: "AvenirNext-Bold", size: 16) as Any, .foregroundColor: valueColor])
        
        attributedTitle.append(NSAttributedString(string: " \(text)",
            attributes: [.font: UIFont(name: "AvenirNext-Medium", size: 12) as Any,
                         .foregroundColor: textColor]))
        return attributedTitle
    }
    
    // MARK: - Helpers
    
    func size(forWidth width: CGFloat) -> CGSize {
        let measurmentLabel = UILabel()
        measurmentLabel.text = caption.caption
        measurmentLabel.numberOfLines = 0
        measurmentLabel.lineBreakMode = .byWordWrapping
        measurmentLabel.translatesAutoresizingMaskIntoConstraints = false
        measurmentLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        return  measurmentLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
    
    
    
}
