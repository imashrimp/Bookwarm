//
//  BookWardmCollectionViewController.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/07/31.
//

//MARK: - 프로퍼티 감시자 사용해서 컬렉션뷰가 업데이트 되도록 해보자

import UIKit
import SwiftyJSON
import Alamofire
import RealmSwift

class BookWardmCollectionViewController: UICollectionViewController {
    
    var realmBook: Results<BookTable>?
    var bookList: [Book] = []
    var distributionID: DistributionID = .none
    
    let realm = try! Realm()
    
    var page: Int = 1
    var isEnd: Bool = false
    
    let searchBar = UISearchBar()
    
    @IBOutlet var searchButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBar()
        configureNavAndTabBar()
        registerNib()
        
        
        collectionView.prefetchDataSource = self
        collectionView.bounces = false
        
        configureCollectionViewLayout()
        confgureNavBarButton()
        

        
        realmBook = realm.objects(BookTable.self)
        
    }
    
    @IBAction func searchButtonTapped(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController")
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
    
    func confgureNavBarButton() {
        searchButton.image = UIImage(systemName: "magnifyingglass")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch distributionID {
        case .searched:
            return bookList.count
        case .none:
            return realmBook?.count ?? 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KaKaoBookCollectionViewCell", for: indexPath) as! KaKaoBookCollectionViewCell
        
        switch distributionID {
        case .searched:
            cell.showBookContents(book: bookList[indexPath.row])
        case .none:
            
            guard let bookData = realmBook else {
                return UICollectionViewCell()
            }
            cell.showSavedBookContents(book: bookData[indexPath.row])
//            cell.showBookContents(book: realmB1ook[indexPath.row])
        }
        

        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  
        let item = bookList[indexPath.row]
                
        let bookToSave = BookTable(title: item.title, author: item.author, thumbnail: item.thumbnail, overview: item.overview, price: item.price)
        
        guard let savedBookList = realmBook else { return }
        
        
        if savedBookList.contains(where: { $0.isbn == bookToSave.isbn }) {
           return
        } else {
            try! realm.write {
                
                realm.add(bookToSave)
                print(bookToSave)
                print("Realm add succeed")
                print(savedBookList)
            }
        }
        
        

        //        let sb = UIStoryboard(name: "Main", bundle: nil)
        //        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        //
        //        vc.book = bookList[indexPath.row]
        //
        //        navigationController?.pushViewController(vc, animated: true)
    }
}

extension BookWardmCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        distributionID = .searched
        guard let keyword = searchBar.text else { return }
        searchBar.resignFirstResponder()
        callRequest(searchWord: keyword, page: page)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        distributionID = .none
        searchBar.text = ""
        bookList.removeAll()
        collectionView.reloadData()
    }
}

extension BookWardmCollectionViewController: CellFlowLayoutProtocol {
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = (UIScreen.main.bounds.width - ( spacing * 3)) / 2
        
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }
}


extension BookWardmCollectionViewController {
    func callRequest(searchWord: String, page: Int) {
        
        let text = "\(searchWord)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)&size=20&page=\(page)"
        let header: HTTPHeaders = ["Authorization": "KakaoAK 4ff3c73e4fc0c6d0b359297fb7f949ba"]
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var book: Book = Book(title: "", author: "", thumbnail: "", overview: "", price: 0, isbn: "")
                
                for item in json["documents"].arrayValue {
                    book.title = item["title"].stringValue
                    book.author = item["authors"].stringValue
                    book.thumbnail = item["thumbnail"].stringValue
                    book.overview = item["contents"].stringValue
                    book.price = item["price"].intValue
                    book.isbn = item["isbn"].stringValue
                    self.bookList.append(book)
                }
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureSearchBar() {
        navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        searchBar.placeholder = "도서명을 검색하세요."
        searchBar.searchBarStyle = .prominent
    }
    
    func configureNavAndTabBar() {
        self.navigationItem.title = "새우의 책장"
        self.tabBarController?.tabBar.tintColor = .black
        self.tabBarController?.tabBar.backgroundColor = .white
    }
    
    func registerNib() {
        let bookCellNib = UINib(nibName: "KaKaoBookCollectionViewCell", bundle: nil)
        collectionView.register(bookCellNib, forCellWithReuseIdentifier: "KaKaoBookCollectionViewCell")
    }
}


extension BookWardmCollectionViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let searchWord = searchBar.text else { return }
        
        for indexPath in indexPaths {
            if bookList.count - 1 == indexPath.row && page < 50 && !isEnd {
                page += 1
                callRequest(searchWord: searchWord, page: page)
            }
        }
    }
}


