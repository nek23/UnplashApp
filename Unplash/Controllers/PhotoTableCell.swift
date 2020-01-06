//
//  PhotoCollectionViewCell.swift
//  Unplash
//
//  Created by Aleksei Kaliev on 06.01.2020.
//  Copyright © 2020 Aleksei Kaliev. All rights reserved.
//

import UIKit

class PhotoTableCell: UITableViewCell {
  
  static let reuseId = "PhotoCell"
  
  let photoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupPhotoImageView()
  }
  
  private func setupPhotoImageView() {
    addSubview(photoImageView)
    photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
