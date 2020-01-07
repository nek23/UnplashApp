//
//  PhotoOfDayViewController.swift
//  Unplash
//
//  Created by Aleksei Kaliev on 05.01.2020.
//  Copyright © 2020 Aleksei Kaliev. All rights reserved.
//

import UIKit

class PhotoOfDayViewController: UIViewController {

  var imageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    PhotoManager.shared.getPhotoOfDay(onSuccess: { (image) in
      self.imageView = UIImageView(image: image)
      self.setupImage()
    }) { (error) in
      print(error)
    }
  }
  
  private func setupImage() {
    view.addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
    imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
    imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
    imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
  }
  
  
}
