//
//  APICaller.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 14.06.24.
//

import Foundation

final class APICaller {
    
    enum NetworkError: Error {
        case urlError
        case parseError
        case postError
        case uncaughtException
    }
    
    enum HttpMethod: String {
        case POST
        case GET
    }
    
    
    static func request<T: Codable> (endpoint: String,
                                     type: T.Type,
                                     method: HttpMethod = .GET,
                                     body: [String:Any]? = nil,
                                     completion: @escaping (Result<T, NetworkError>) -> Void)
    {
        guard let url = URL(string: "http://localhost:3000/" + endpoint) else {
            completion(.failure(.urlError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let body = body {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: body)
                request.httpBody = jsonData
            } catch {
                completion(.failure(.uncaughtException))
                return
            }
        }
        
        URLSession(configuration: .default,
                   delegate: .none,
                   delegateQueue: .main)
        .dataTask(with: request)
        { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.parseError))
                return
            }
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                completion(.success(json))
            }
            catch {
                completion(.failure(.parseError))
                return
            }
        }.resume()
    }
}
