//
//  PhotosViewController.swift
//  Unplash
//
//  Created by Aleksei Kaliev on 06.01.2020.
//  Copyright © 2020 Aleksei Kaliev. All rights reserved.
//

import UIKit
import Kingfisher

class PhotosViewController: UITableViewController {
  
  var photos: [Photo] = []
  var isSearchBarHidden = false
  var collectionID: Int!
  var pageCount = 1
  var currentQuery = ""
  private let searchController = UISearchController(searchResultsController: nil)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    guard isSearchBarHidden else { setupSearchBar(); return }
    loadCollectionPhotos()
  }
  
  private func loadCollectionPhotos() {
    PhotoManager.shared.collection(page: pageCount, id: collectionID, onSuccess: { (photos) in
      self.photos.append(contentsOf: photos)
      self.tableView.reloadData()
    }) { (error) in
      self.showAlertError(error)
    }
  }
  
  private func loadPhoto(query: String?) {
    guard let query = query, query != "" else { return }
    PhotoManager.shared.searchPhotos(page: pageCount, query: query, onSuccess: { (searchResults) in
      self.photos.append(contentsOf: searchResults.results)
      self.tableView.reloadData()
    }) { (error) in
      self.showAlertError(error)
    }
  }
  
  private func resetSearch() {
    photos.removeAll()
    pageCount = 1
    tableView.reloadData()
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
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.item == photos.count - 1 {
      pageCount += 1
      isSearchBarHidden ? loadCollectionPhotos() : loadPhoto(query: currentQuery)
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableCell.reuseId, for: indexPath) as? PhotoTableCell else { return UITableViewCell() }
    cell.photoImageView.backgroundColor = UIColor(hexString: photos[indexPath.row].color)
    cell.photoImageView.kf.indicatorType = .activity
    cell.photoImageView.kf.setImage(with: URL(string: photos[indexPath.row].urls[URLKind.regular.rawValue] ?? ""))
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as? PhotoTableCell
    let vc = DetailPhotoViewController()
    vc.background = cell?.photoImageView.image?.averageColor
    vc.imageURL = photos[indexPath.row].urls[URLKind.full.rawValue] ?? ""
    vc.modalPresentationStyle = .fullScreen
    vc.photo = photos[indexPath.row]
    present(vc, animated: true, completion: nil)
  }
}

extension PhotosViewController: UISearchBarDelegate {
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    guard currentQuery != searchBar.text ?? "" else { return }
    resetSearch()
    currentQuery = searchBar.text ?? ""
    loadPhoto(query: searchBar.text)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    resetSearch()
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText == "" { resetSearch() }
  }
}
