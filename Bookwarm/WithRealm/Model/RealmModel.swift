//
//  RealmModel.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/09/04.
//

import Foundation
import RealmSwift

class BookTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var isbn: String
    @Persisted var title: String
    @Persisted var author: String?
    @Persisted var publisher: String?
    @Persisted var thumbnail: String?
    @Persisted var overview: String?
    @Persisted var price: Int?
    @Persisted var memo: String?
    
    
    convenience init(isbn: String,
                     title: String,
                     author: String?,
                     publisher: String?,
                     thumbnail: String?,
                     overview: String?,
                     price: Int?,
                     memo: String?)
    {
        self.init()
        self.isbn = isbn
        self.title = title
        self.author = author
        self.publisher = publisher
        self.thumbnail = thumbnail
        self.overview = overview
        self.price = price
        self.memo = memo
    }
}
