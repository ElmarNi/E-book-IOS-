//
//  BooksViewModel.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 15.08.24.
//

import Foundation

final class BooksViewModel {
    var books = [BookShortInfo]()
    
    func data(completion: @escaping (Bool) -> Void) {
        APICaller.request(endpoint: "books", type: [BookShortInfo].self, method: .GET)
        {[weak self] result in
            switch result {
            case let .success(data):
                self?.books = data
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
    
    func numberOfRows(in section: Int) -> Int {
        books.count
    }
    
    func book(at indexPath: IndexPath) -> BookShortInfo {
        books[indexPath.row]
    }
    
}
