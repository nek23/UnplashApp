//
//  Photo.swift
//  Unplash
//
//  Created by Aleksei Kaliev on 06.01.2020.
//  Copyright © 2020 Aleksei Kaliev. All rights reserved.
//

import Foundation

struct Photo: Decodable {
  let width: Int
  let height: Int
  let description: String?
  let color: String
  let urls: [URLKind.RawValue: String]
}

enum URLKind: String {
  case full
  case regular
  case thumb
}

struct SearchResults: Decodable {
    let total: Int
    let results: [Photo]
}
