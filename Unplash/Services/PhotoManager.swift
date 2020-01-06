import Foundation
import Alamofire
import SwiftyJSON

class PhotoManager {
  
  static let shared = PhotoManager()
  
  func searchPhotos(query: String, onSuccess: @escaping(SearchResults) -> Void, onFailure: @escaping(String) -> Void) {
    guard let url = URL(string: APIConstants.searchPhotos) else { return }
    let parameters: [String: Any] = ["client_id": APIConstants.accessKey, "query": query]
    Alamofire.request(
      url,
      method: .get,
      parameters: parameters,
      encoding: URLEncoding.default,
      headers: nil).responseData { (response) in
        switch response.result {
        case .success(let value):
          if NetworkManagerConstants.failureCondition(for: response) {
            let json = JSON(value)
            onFailure(json.description)
          } else {
            do {
              let json = response.data
              let decoder = JSONDecoder()
              let jsonData = try decoder.decode(SearchResults.self, from: json!)
              onSuccess(jsonData)
            } catch {
              onFailure(error.localizedDescription)
            }
          }
        case .failure(let error):
          print("error")
          onFailure(error.localizedDescription)
        }
    }
  }
  
  func getPhotoOfDay(onSuccess: @escaping(UIImage) -> Void, onFailure: @escaping(String) -> Void) {
    guard let url = URL(string: APIConstants.daily) else { return }
    Alamofire.request(
      url,
      method: .get,
      parameters: nil,
      encoding: URLEncoding.default,
      headers: nil).responseData { (response) in
        switch response.result {
        case .success(let value):
          if NetworkManagerConstants.failureCondition(for: response) {
            let json = JSON(value)
            onFailure(json.description)
          } else {
            guard let data = response.data else { return }
            guard let image = UIImage(data: data) else { return }
            onSuccess(image)
          }
        case .failure(let error):
          print("error")
          onFailure(error.localizedDescription)
        }
    }
  }
}
