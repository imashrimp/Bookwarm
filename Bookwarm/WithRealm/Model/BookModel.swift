//
//  BookModel.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/09/05.
//

import Foundation

struct BookModel: Codable {
    let documents: [Document]
    let meta: Meta
}

// MARK: - Document
struct Document: Codable {
    let authors: [String]
    let contents, isbn: String
    let price: Int
    let publisher: String
    let thumbnail: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case authors, contents, isbn, price, publisher
        case thumbnail, title
    }
}

// MARK: - Meta
struct Meta: Codable {
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
