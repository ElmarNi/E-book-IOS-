//
//  ForgotPasswordViewModel.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 18.07.24.
//

import Foundation

final class ForgotPasswordViewModel {
    func forgotPassword (email: String, completion: @escaping (Bool) -> Void) {
        let body = ["email": email]
        DispatchQueue.main.async {
            APICaller.request(endpoint: "forgotPassword", type: [String: Bool].self, method: .POST, body: body)
            { result in
                switch result {
                case let .success(data):
                    if let success = data["success"] {
                        completion(success)
                        return
                    }
                    completion(false)
                case .failure:
                    completion(false)
                }
            }
        }
    }
}
