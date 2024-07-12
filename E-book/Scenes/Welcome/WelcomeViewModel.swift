//
//  WelcomeViewModel.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 02.07.24.
//

import Foundation

final class WelcomeViewModel {
    var dataSource = [Welcome]()
    
    func data(urlSessionDelegate: URLSessionDelegate, completion: @escaping (Bool) -> Void) {
        APICaller.request(endpoint: "welcome",
                          type: [Welcome].self,
                          method: .GET,
                          urlSessionDelegate: urlSessionDelegate)
        {[weak self] result in
            switch result {
            case let .success(data):
                self?.dataSource = data
                completion(true)
            case let .failure(error):
                print(error)
                completion(false)
            }
        }
    }
}
