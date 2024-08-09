//
//  RegisterViewModel.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 22.07.24.
//

import Foundation

final class RegisterViewModel {
    func register (email: String, password: String, completion: @escaping (Login?) -> Void) {
        let body = ["email": email, "password": password]
        DispatchQueue.main.async {
            APICaller.request(endpoint: "register", type: Login.self, method: .POST, body: body)
            { result in
                switch result {
                case let .success(data):
                    completion(data)
                case .failure:
                    completion(nil)
                }
            }
        }
    }
}
