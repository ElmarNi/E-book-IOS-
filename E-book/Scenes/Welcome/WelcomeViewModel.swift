//
//  WelcomeViewModel.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 02.07.24.
//

import Foundation

final class WelcomeViewModel {
    var dataSource = [Welcome]()
    
    func data(completion: @escaping (Bool) -> Void) {
        APICaller.request(endpoint: "welcome", type: [Welcome].self)
        {[weak self] result in
            switch result {
            case let .success(data):
                self?.dataSource = data
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
}
