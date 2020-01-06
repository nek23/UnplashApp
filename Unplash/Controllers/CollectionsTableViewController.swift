//
//  CollectionsTableViewController.swift
//  Unplash
//
//  Created by Aleksei Kaliev on 06.01.2020.
//  Copyright © 2020 Aleksei Kaliev. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionsTableViewController: UITableViewController {
  
  var collections: [Collection] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadCollections()
  }
  
  private func loadCollections() {
    PhotoManager.shared.collections(onSuccess: { (collections) in
      self.collections = collections
      self.tableView.reloadData()
    }) { (error) in
      print(error)
    }
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return collections.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "CollectionCell")
    cell.textLabel?.text = collections[indexPath.row].title
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = SearchPhotosViewController()
    vc.isSearchBarHidden = true
    vc.title = collections[indexPath.row].title
    vc.collectionID = collections[indexPath.row].id
    if let navigator = navigationController {
        navigator.pushViewController(vc, animated: true)
    }
  }
}
