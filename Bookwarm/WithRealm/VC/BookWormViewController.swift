//
//  BookWormViewController.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/09/05.
//

import UIKit
import SnapKit

class BookWormViewController: UIViewController {
    
    var books: BookModel?
    
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
        view.addSubview(collectionView)
        navigationItem.titleView = searchBar()
        setConstraints()
        
        APIMananger.shared.callRequest(keyword: "소고기") { bookData in
            self.books = bookData
        }
    }
    
    func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension BookWormViewController: UICollectionViewDelegate {
    
}

extension BookWormViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KaKaoBookCollectionViewCell.id, for: indexPath) as?
                KaKaoBookCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.imageView.image = UIImage(systemName: "star")
        cell.bookTitlelabel.text = "제목"
        
        return cell
    }
}

extension BookWormViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // 여기는 화면에 띄운 컬렉션뷰 초기화
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //여기서 api 호출
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
