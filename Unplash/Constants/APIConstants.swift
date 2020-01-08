struct APIConstants {
  static let accessKey = "37eaf849b490637cf74de2aba602ce53fd9bae7a576f31b61962a18bc73114d6"
  
  static let unplash = "https://api.unsplash.com"
  static func collection(id: Int) -> String {
    return unplash + "/collections/\(id)/photos"
  }
  static let searchPhotos = unplash + "/search/photos"
  static let collections = unplash + "/collections"
  static let daily = "https://source.unsplash.com/daily"
}
