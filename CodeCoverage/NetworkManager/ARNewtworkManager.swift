//
//  ARNewtworkManager.swift
//  ThemeSample
//
//  Created by Ashok Rawat on 22/04/22.
//

import Foundation

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
    
    var method: String { rawValue.uppercased() }
}

enum ARNetworkError: Error {
    case invalidUrl
    case invalidData
}

struct API {
    static let baseURL = "https://saurav.tech/NewsAPI/"
    static let sourceService = "sources.json"
}

struct ARNewtworkManager {
    private let baseURL: URL
    private let httpMethod: String
    
    public init?(_ baseURL: String, httpMethod: HTTPMethod = .GET) {
        guard let baseURL = URL(string: baseURL) else { return nil }
        self.baseURL = baseURL
        self.httpMethod = httpMethod.method
    }
     
    public func createRequest(service: String?, params: [String: Any]?) -> URLRequest? {
        var url = self.baseURL
        if let service = service {
            url = self.baseURL.appendingPathComponent(service)
        }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.networkServiceType = .default
        request.cachePolicy = .reloadRevalidatingCacheData
        request.timeoutInterval = 100
        request.httpShouldHandleCookies = true
        request.httpShouldUsePipelining = false
        request.allowsCellularAccess = true
        if let params = params {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        return request
    }
    
    public func executeRequest<T: Codable>(request: URLRequest, completion: ((T?, Error?) -> Void)?) {
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: request) { (data, _, error) in
            guard let data = data else {
                completion?(nil, error)
                return
            }
            if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    completion?(decodedResponse, nil)
                }
            } else {
                completion?(nil, ARNetworkError.invalidData)
            }
        }
        dataTask.resume()
    }
}
