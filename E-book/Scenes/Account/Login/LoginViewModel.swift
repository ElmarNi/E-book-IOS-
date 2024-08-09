//
//  LoginViewModel.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 18.07.24.
//

import Foundation

final class LoginViewModel {
    func login (email: String, password: String, completion: @escaping (Login?) -> Void) {
        let body = ["email": email, "password": password]
        DispatchQueue.main.async {
            APICaller.request(endpoint: "login", type: Login.self, method: .POST, body: body)
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
