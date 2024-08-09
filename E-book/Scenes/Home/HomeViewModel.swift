//
//  HomeViewModel.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 26.07.24.
//

import Foundation

final class HomeViewModel {
    
    var categories = [Category]()
    var recommendedBooks = [BookShortInfo]()
    var newBooks = [BookShortInfo]()
    
    enum `Type`: String {
        case book
        case audioBook
    }
    
    func numberOfRows(in section: Int) -> Int {
        switch section {
        case 0:
            return categories.count
        case 1:
            return recommendedBooks.count
        case 2:
            return newBooks.count
        default:
            return 0
        }
    }
    
    func titleForHeader(in section: Int) -> String {
        switch section {
        case 1:
            return "Рекомендуем"
        case 2:
            return "Новинки этой недели"
        default:
            return ""
        }
    }
    
    func category(at indexPath: IndexPath) -> Category {
        return categories[indexPath.row]
    }
    
    func recommendedBook(at indexPath: IndexPath) -> BookShortInfo {
        return recommendedBooks[indexPath.row]
    }
    
    func newBook(at indexPath: IndexPath) -> BookShortInfo {
        return newBooks[indexPath.row]
    }
    
    func data(type: Type, completion: @escaping (Bool) -> Void) {
        let body: [String: Any] = ["type": type.rawValue]
        DispatchQueue.main.async {
            APICaller.request(endpoint: "home", type: HomeResponse.self, method: .POST, body: body)
            {[weak self] result in
                switch result {
                case let .success(data):
                    self?.categories = data.categories
                    self?.recommendedBooks = data.recommendedBooks
                    self?.newBooks = data.newBooks
                    completion(true)
                case .failure(_):
                    completion(false)
                }
            }
        }
    }
}
