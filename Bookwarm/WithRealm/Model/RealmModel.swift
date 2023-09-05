//
//  RealmModel.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/09/04.
//

import Foundation
import RealmSwift

class BookTable: Object {

    @Persisted(primaryKey: true) var isbn: String
    @Persisted var title: String
    @Persisted var author: String?
    @Persisted var thumbnail: String?
    @Persisted var overview: String?
    @Persisted var price: Int?

    
    convenience init(isbn: String,
                     title: String,
                     author: String?,
                     thumbnail: String? ,
                     overview: String? ,
                     price: Int?) {
        self.init()
        self.isbn = isbn
        self.title = title
        self.author = author
        self.thumbnail = thumbnail
        self.overview = overview
        self.price = price
    }
}
