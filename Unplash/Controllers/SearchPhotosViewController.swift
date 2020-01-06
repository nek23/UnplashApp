//
//  SearchPhotosViewController.swift
//  Unplash
//
//  Created by Aleksei Kaliev on 06.01.2020.
//  Copyright © 2020 Aleksei Kaliev. All rights reserved.
//

import UIKit
import Kingfisher

class SearchPhotosViewController: UITableViewController {
  
  var photos: [Photo] = []
  private let searchController = UISearchController(searchResultsController: nil)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    setupSearchBar()
  }
  
  private func loadPhoto(query: String?) {
    guard let query = query, query != "" else { return }
    PhotoManager.shared.searchPhotos(query: query, onSuccess: { (searchResults) in
      self.photos = searchResults.results
      self.tableView.reloadData()
    }) { (error) in
      print(error)
    }
  }
  
  private func setupSearchBar() {
    searchController.searchBar.placeholder = "Поиск"
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.delegate = self
    navigationItem.searchController = searchController
  }
  
  private func setupTableView() {
    tableView.register(PhotoTableCell.self, forCellReuseIdentifier: PhotoTableCell.reuseId)
    tableView.rowHeight = 250
  }
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return photos.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableCell.reuseId, for: indexPath) as? PhotoTableCell else { return UITableViewCell() }
    cell.photoImageView.backgroundColor = UIColor(hexString: photos[indexPath.row].color)
    cell.photoImageView.kf.indicatorType = .activity
    cell.photoImageView.kf.setImage(with: URL(string: photos[indexPath.row].urls[URLKind.regular.rawValue] ?? ""))
    return cell
  }
}

extension SearchPhotosViewController: UISearchBarDelegate {
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    loadPhoto(query: searchBar.text)
  }
}