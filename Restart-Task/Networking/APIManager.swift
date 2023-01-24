//
//  APIManager.swift
//  RestartTask
//
//  Created by Mohamed Elshaer on 23/01/2023.
//

import Alamofire

class APIManager{
    //Fetch Product List.
    static func getProducts(completion: @escaping (Result<Product?, Error>, _ code: Int?) -> ()){
        request(APIRouter.products){ response, code in
            completion(response, code)
        }
    }
}

extension APIManager {
    // MARK: - The request function to get results in a closure.
    internal static func request<T: Decodable>(_ urlConvertible: URLRequestConvertible, completion:  @escaping (Result<T, Error>, _ code: Int?) -> ()) {
        // Trigger the HttpRequest using AlamoFire
        AF.request(urlConvertible).responseDecodable { (response: AFDataResponse<T>) in
            switch response.result {
            case .success(let value):
                completion(.success(value), response.response?.statusCode)
            case .failure(let error):
                completion(.failure(error), response.response?.statusCode)
            }
        }
        .responseJSON { response in
            print(response)
            print(response.response?.statusCode ?? 000)
        }
    }
}
