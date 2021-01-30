//
//  NetworkRouter.swift
//  PryanikiTestTask
//
//  Created by Иван Юшков on 30.01.2021.
//

import Alamofire

import Foundation
import Alamofire

class Network {
    static let mainPath = "https://pryaniky.com/static/json/sample.json"
    
}

public enum NetworkRouter: URLRequestConvertible {
   
    case getPryanikyData([String: Any])
    
    public func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .getPryanikyData:
                return .get
            }
        }
        let params: ([String: Any]?) = {
            switch self {
            case .getPryanikyData(let json):
                return json
            }
        }()
        let url: URL = {
            guard let url = URL(string: Network.mainPath) else { fatalError() }
            return url
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        return try encoding.encode(urlRequest, with: params)
    }
}

