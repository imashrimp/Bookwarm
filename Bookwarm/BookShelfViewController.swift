//
//  BookShelfViewController.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/08/02.
//

import UIKit

class BookShelfViewController: UIViewController {

    var movieList = MovieList().movie
    
    
    @IBOutlet var bookshelfTableView: UITableView!
    @IBOutlet var bookshelfCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookshelfTableView.dataSource = self
        bookshelfTableView.delegate = self
        bookshelfTableView.rowHeight = 200
        
        
        
        self.navigationController?.navigationBar.isHidden = true
        
        let tableViewCellNib = UINib(nibName: "BookShelfTableViewCell", bundle: nil)
        bookshelfTableView.register(tableViewCellNib, forCellReuseIdentifier: "BookShelfTableViewCell")
        
        bookshelfCollectionView.dataSource = self
        bookshelfCollectionView.delegate = self
        configureCollectionViewLayout()
        
        let collectionViewCellNib = UINib(nibName: "BookShelfCollectionViewCell", bundle: nil)
        bookshelfCollectionView.register(collectionViewCellNib, forCellWithReuseIdentifier: "BookShelfCollectionViewCell")
    }
    
    
    
}

extension BookShelfViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookShelfTableViewCell") as! BookShelfTableViewCell
        cell.showData(movie: movieList[indexPath.row])
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        movieList[sender.tag].like.toggle()
        bookshelfTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        vc.movieData = movieList[indexPath.row]
        vc.dismissButtonIdentifier = true
        
        present(nav, animated: true)
    }
    
}

extension BookShelfViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let height = UIScreen.main.bounds.height / 5
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: height)
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.minimumInteritemSpacing = 8
        bookshelfCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookShelfCollectionViewCell", for: indexPath) as! BookShelfCollectionViewCell
        
        cell.showMovieImage(movie: movieList[indexPath.item])
        
        return cell
    }
}
