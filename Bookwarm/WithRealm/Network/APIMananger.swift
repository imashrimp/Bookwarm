//
//  APIMananger.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/09/05.
//

import Foundation
import Alamofire

class APIMananger {
    
    static let shared = APIMananger()
    
    private init() { }
    
    func callRequest(keyword: String, completionHandler: @escaping (BookModel) -> Void) {
        
        let text = "\(keyword)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)&size=50"
        
        let header: HTTPHeaders = ["Authorization": APIKeys.kakao]
        
        AF.request(url, method: .get, headers: header).validate()
            .responseDecodable(of: BookModel.self) { response in
                let value = response.result
                dump(response)
                print("=========")
                
                switch value {
                case .success(let success):
                    dump(success)
                    completionHandler(success)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
