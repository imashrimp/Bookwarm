//
//  BookWormViewController.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/09/05.
//

import UIKit
import SnapKit
import RealmSwift

final class BookWormViewController: UIViewController {
    
    private var bookInfo: [Document] = []
    
    private lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        view.register(KaKaoBookCollectionViewCell.self,
                      forCellWithReuseIdentifier: KaKaoBookCollectionViewCell.id)
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    private lazy var searchBar = {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension BookWormViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = BookDetailInfoViewController()
        
        let book = bookInfo[indexPath.row]
        
        vc.book = BookTable(isbn: book.isbn,
                            title: book.title,
                            author: book.authors.first,
                            publisher: book.publisher,
                            thumbnail: book.thumbnail,
                            overview: book.contents,
                            price: book.price,
                            memo: nil)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension BookWormViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = bookInfo[indexPath.row]
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KaKaoBookCollectionViewCell.id, for: indexPath) as?
                KaKaoBookCollectionViewCell,
            let url = URL(string: item.thumbnail) else {
            return UICollectionViewCell()
        }
        
        
        cell.bookTitlelabel.text = item.title
        DispatchQueue.global().async {
            
            do {
                let urlData = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: urlData)
                }
            } catch {
                cell.imageView.image = UIImage(systemName: "star.fill")
            }
        }
        return cell
    }
}

extension BookWormViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = ""
        bookInfo.removeAll()
        collectionView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let keyword = searchBar.text else { return }
        searchBar.resignFirstResponder()
        APIMananger.shared.callRequest(keyword: keyword) { bookData in
            self.bookInfo = bookData.documents
            self.collectionView.reloadData()
        }
    }
}

extension BookWormViewController {
    
    private func configureCollectionViewLayout() -> UICollectionViewFlowLayout {
        
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
