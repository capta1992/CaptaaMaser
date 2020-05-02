//
//  CustomImageView.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/1/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
    
    var lastImgUrlUsedToLoadImage: String?
    
    var button = UIButton(type: .system)
    
    func loadImage(with urlString: String) {
      
      
      // Set Image To Nil
      self.image = nil
    
      
      // Set lastImgUrlToLoad
      lastImgUrlUsedToLoadImage = urlString
      
      
      // Check If Image Exists In Cache
      if let cachedImage = imageCache[urlString] {
          self.image = cachedImage
       
          return
      }
      
      // Url For Image Location
      guard let url = URL(string: urlString) else {return}
      
      // Fetch Contents Of URL
      URLSession.shared.dataTask(with: url) { (data, response, error) in
          // Handle Error
          if let error = error {
              print("Failed To Load Image With Error", error.localizedDescription)
          }
          
          if self.lastImgUrlUsedToLoadImage != url.absoluteString {
              return
          }
          
          // Image Data
          guard let imageData = data else {return}
          
          // Create Image Using Image Data
          let photoImage = UIImage(data: imageData)
          
          // Set Key And Value For Image Cache
          imageCache[url.absoluteString] = photoImage
          
          // Set Image
          DispatchQueue.main.async {
              self.image = photoImage
          }
          
          }.resume()
      
  }
    
}
