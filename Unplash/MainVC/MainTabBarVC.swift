//
//  MainTabBarVC.swift
//  Unplash
//
//  Created by Aleksei Kaliev on 06.01.2020.
//  Copyright © 2020 Aleksei Kaliev. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewControllers = [
      generateNavigationController(rootViewController: PhotoOfDayViewController(), title: "Фото дня", image: #imageLiteral(resourceName: "dailyPhotoTab")),
      generateNavigationController(rootViewController: PhotosViewController(), title: "Найти фото", image: #imageLiteral(resourceName: "searchTab")),
      generateNavigationController(rootViewController: CollectionsTableViewController(), title: "Коллекции", image: #imageLiteral(resourceName: "collectionsTab")),
    ]
  }
  
  private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
    rootViewController.title = title
    let navigationVC = UINavigationController(rootViewController: rootViewController)
    navigationVC.tabBarItem.title = title
    navigationVC.tabBarItem.image = image
    return navigationVC
  }
  
}
