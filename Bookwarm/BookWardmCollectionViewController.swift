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

class BookWardmCollectionViewController: UICollectionViewController {
    
    var bookList: [Book] = []
    
    let searchBar = UISearchBar()
    
    @IBOutlet var searchButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        searchBar.placeholder = "도서명을 검색하세요."
        searchBar.searchBarStyle = .prominent
        
        self.navigationItem.title = "새우의 책장"
        self.tabBarController?.tabBar.tintColor = .black
        self.tabBarController?.tabBar.backgroundColor = .white
        
        let bookCellNib = UINib(nibName: "KaKaoBookCollectionViewCell", bundle: nil)
        collectionView.register(bookCellNib, forCellWithReuseIdentifier: "KaKaoBookCollectionViewCell")
        
        collectionView.bounces = false
        
        configureCollectionViewLayout()
        confgureNavBarButton()
        
    }
    
    @IBAction func searchButtonTapped(_ sender: UIBarButtonItem) {
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController")
//        let nav = UINavigationController(rootViewController: vc)
//
//        nav.modalPresentationStyle = .fullScreen
//
//        present(nav, animated: true)
        collectionView.reloadData()
    }
    
    @IBAction func tappedToDismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    func confgureNavBarButton() {
        searchButton.image = UIImage(systemName: "magnifyingglass")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KaKaoBookCollectionViewCell", for: indexPath) as! KaKaoBookCollectionViewCell
        
        cell.showBookContents(book: bookList[indexPath.row])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController

        vc.book = bookList[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension BookWardmCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else {
            callRequest(keyword: "")
            return
        }
        callRequest(keyword: keyword)

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
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
    func callRequest(keyword: String) {
        
        //MARK: - text가 빈 경우 대체 텍스트 넣어주기
        let text = "\(keyword)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)"
        let header: HTTPHeaders = ["Authorization": "KakaoAK 4ff3c73e4fc0c6d0b359297fb7f949ba"]
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var book: Book = Book(title: "", author: "", thumbnail: "", overview: "", price: 0)
                for item in json["documents"].arrayValue {
                    book.title = item["title"].stringValue
                    book.author = item["authors"].stringValue
                    book.thumbnail = item["thumbnail"].stringValue
                    book.overview = item["contents"].stringValue
                    book.price = item["price"].intValue
                    self.bookList.append(book)
                }
                print(self.bookList)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
