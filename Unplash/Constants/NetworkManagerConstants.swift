import Alamofire

class NetworkManagerConstants {
  static func failureCondition(for response: DataResponse<Data>) -> Bool {
    return response.response?.statusCode != 200 && response.response?.statusCode != 201
  }
}
