//
//  HomeResponse.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 26.07.24.
//

import Foundation

struct HomeResponse: Codable {
    let categories: [Category]
    let recommendedBooks: [BookShortInfo]
    let newBooks: [BookShortInfo]
    let success: Bool
}
