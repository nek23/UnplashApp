struct APIConstants {
  static let accessKey = "6a5917b4c5eae9fd55fd558cff0a158dbe6b521de28c017800de6e402407046c"
  
  static let unplash = "https://api.unsplash.com"
  static func collection(id: Int) -> String {
    return unplash + "/collections/\(id)/photos"
  }
  static let searchPhotos = unplash + "/search/photos"
  static let collections = unplash + "/collections"
  static let daily = "https://source.unsplash.com/daily"
}
