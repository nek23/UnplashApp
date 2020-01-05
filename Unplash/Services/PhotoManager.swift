import Foundation
import Alamofire
import SwiftyJSON

class PhotoManager {
  
  static let shared = PhotoManager()
  
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
