//
//  Extension+UIViewController.swift
//  Unplash
//
//  Created by Aleksei Kaliev on 06.01.2020.
//  Copyright © 2020 Aleksei Kaliev. All rights reserved.
//
import UIKit

extension UIViewController {
  func showAlertError(_ message: String, action: ((UIAlertAction) -> Void)? = nil) {
    let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: action))
    self.present(alert, animated: true, completion: nil)
  }
  
  func showAlert(_ message: String) {
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
