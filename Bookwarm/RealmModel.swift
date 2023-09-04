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
    @Persisted var title: String
    @Persisted var author: String?
    @Persisted var thumnail: String?
    @Persisted var overview: String?
    @Persisted var price: Int?
    
    convenience init(title: String,
                     author: String?,
                     thumnail: String? ,
                     overview: String? ,
                     price: Int?) {
        self.init()
        self.title = title
        self.author = author
        self.thumnail = thumnail
        self.overview = overview
        self.price = price
    }
}
