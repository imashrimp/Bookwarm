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
    @Persisted var publisher: String?
    @Persisted var thumbnail: String?
    @Persisted var overview: String?
    @Persisted var price: Int?
    @Persisted var like: Bool?
    @Persisted var myMemo: String?
    
    
    convenience init(isbn: String,
                     title: String,
                     author: String?,
                     publisher: String?,
                     thumbnail: String?,
                     overview: String?,
                     price: Int?,
                     like: Bool?,
                     myMemo: String?)
    {
        self.init()
        self.isbn = isbn
        self.title = title
        self.author = author
        self.publisher = publisher
        self.thumbnail = thumbnail
        self.overview = overview
        self.price = price
        self.like = like
        self.myMemo = myMemo
    }
}
