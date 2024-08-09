//
//  BookShortInfo.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 26.07.24.
//

import Foundation

struct BookShortInfo: Codable {
    let id: String
    let name: String
    let author: String
    let rating: Int
}
