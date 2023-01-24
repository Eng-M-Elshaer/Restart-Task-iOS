//
//  APIRouter.swift
//  RestartTask
//
//  Created by Mohamed Elshaer on 23/01/2023.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
    
    // MARK: - Cases
    case products
    
    // MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self{
        case .products:
            return .get
        default:
            return .post
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .products:
            return URLs.products
        default:
            return ""
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        default:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try URLs.base.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP method
        urlRequest.httpMethod = method.rawValue
        
        // Headers
        switch self {
       
        default:
            break
        }
        
      
        // HTTP Body
        let httpBody: Data? = {
            switch self {
            default:
                return nil
            }
        }()
        
        urlRequest.httpBody = httpBody
        
        // Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get, .delete:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        print(try encoding.encode(urlRequest, with: parameters))
        return try encoding.encode(urlRequest, with: parameters)
    }
}

//MARK: - encodeToJSON
extension APIRouter {
    private func encodeToJSON<T: Encodable>(_ body: T) -> Data? {
        do {
            let anyEncodable = AnyEncodable(body)
            let jsonData = try JSONEncoder().encode(anyEncodable)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            return jsonData
        } catch {
            print(error)
            return nil
        }
    }
}

// type-erasing wrapper
struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    public init<T: Encodable>(_ wrapped: T) {
        _encode = wrapped.encode
    }
    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}
