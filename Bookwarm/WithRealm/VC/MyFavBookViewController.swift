//
//  MyFavBookViewController.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/09/06.
//

import UIKit
import SnapKit
import RealmSwift

class MyFavBookViewController: UIViewController {
    
    let realm = try! Realm()
    
    var savedBooks: Results<BookTable>?
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: configureCollectionViewLayout())
        view.register(KaKaoBookCollectionViewCell.self,
                      forCellWithReuseIdentifier: KaKaoBookCollectionViewCell.id)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(realm.configuration.fileURL)
        view.backgroundColor = .white
        view.addSubview(collectionView)
        configure()
        setConstraints()
        savedBooks = realm.objects(BookTable.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        collectionView.reloadData()
    }
}

extension MyFavBookViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let dataList = savedBooks else { return }
        
        let bookToRemove = dataList[indexPath.row]
        
        removeImageFromDocument(fileName: "imashrimp\(bookToRemove._id).jpg")
        
        try! realm.write {
            realm.delete(bookToRemove)
        }
        
        collectionView.reloadData()
    }
}

extension MyFavBookViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard
            let books = savedBooks else {
            return 0
        }
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KaKaoBookCollectionViewCell.id,
                                                          for: indexPath) as? KaKaoBookCollectionViewCell,
                let books = savedBooks else {
            return UICollectionViewCell()
        }
        
        cell.bookTitlelabel.text = books[indexPath.row].title
        
        guard
            let bookImage = loadImageFromDocument(fileName: "imashrimp\(books[indexPath.row]._id).jpg") else {
            return UICollectionViewCell()
        }
        
        cell.imageView.image = bookImage
        
        return cell
    }
    
    
}

extension MyFavBookViewController {
    
    func configure() { }
    
    func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
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
