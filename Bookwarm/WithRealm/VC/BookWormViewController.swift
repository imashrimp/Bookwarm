//
//  BookWormViewController.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/09/05.
//

import UIKit
import SnapKit
import RealmSwift

class BookWormViewController: UIViewController {
    
    var bookInfo: [Document] = []
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        view.register(KaKaoBookCollectionViewCell.self,
                                forCellWithReuseIdentifier: KaKaoBookCollectionViewCell.id)
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    lazy var searchBar = {
        let view = UISearchBar()
        view.delegate = self
        view.showsCancelButton = true
        view.placeholder = "도서명을 검색하세요."
        view.searchBarStyle = .prominent
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        navigationItem.titleView = searchBar()
        setConstraints()
    }
    
    func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension BookWormViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = BookDetailInfoViewController()

        vc.book = bookInfo[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
        
//        여기서는 realm에 저장
//        let item = bookInfo[indexPath.row]
//
//        let book = BookTable(isbn: item.isbn, title: item.title, author: item.authors.first, thumbnail: item.thumbnail, overview: item.contents, price: item.price)
//
//        let realm = try! Realm()
//
//        try! realm.write {
//            realm.add(book)
//            print("저장됨")
//            print(realm.configuration.fileURL)
//        }
    }
}

extension BookWormViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                
        return bookInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KaKaoBookCollectionViewCell.id, for: indexPath) as?
                KaKaoBookCollectionViewCell else {
            return UICollectionViewCell()
        }

        let item = bookInfo[indexPath.row]
        
        cell.imageView.image = UIImage(systemName: "star")
        cell.bookTitlelabel.text = item.title
        
        return cell
    }
}

extension BookWormViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // 여기는 화면에 띄운 컬렉션뷰 초기화
//        var booklist = book.documents
        searchBar.text = ""
        bookInfo.removeAll()
        collectionView.reloadData()
    
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //여기서 api 호출
        guard let keyword = searchBar.text else { return }
        searchBar.resignFirstResponder()
        APIMananger.shared.callRequest(keyword: keyword) { bookData in
            self.bookInfo = bookData.documents
            self.collectionView.reloadData()
        }
    }
}

extension BookWormViewController {
    
    func configureCollectionViewLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = (UIScreen.main.bounds.width - ( spacing * 3)) / 2
        
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        return layout
    }
}
