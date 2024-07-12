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
    }
    
    enum HttpMethod: String {
        case POST
        case GET
    }
    
    
    static func request<T: Codable> (endpoint: String,
                                     type: T.Type,
                                     method: HttpMethod,
                                     urlSessionDelegate: URLSessionDelegate,
                                     completion: @escaping (Result<T, NetworkError>) -> Void)
    {
        guard let url = URL(string: "http://localhost:3000/" + endpoint) else {
            completion(.failure(.urlError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        URLSession(configuration: .default,
                   delegate: urlSessionDelegate,
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
