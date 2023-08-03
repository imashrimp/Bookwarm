//
//  BookWardmCollectionViewController.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/07/31.
//

import UIKit

class BookWardmCollectionViewController: UICollectionViewController, LikeButtonProtocol {
    
    var movieList = MovieList()
    let searchBar = UISearchBar()
    var searchMovieList: [Movie] = []
    var searchBarState: SearchBarTextState = .empty

    @IBOutlet var searchButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        searchBar.placeholder = "영화를 검색하세요."
        searchBar.searchBarStyle = .prominent
        
        self.navigationItem.title = "새우의 책장"
        self.tabBarController?.tabBar.tintColor = .black
        self.tabBarController?.tabBar.backgroundColor = .white
        
        let collectionViewCellNib = UINib(nibName: "BookWarmCollectionViewCell", bundle: nil)
        collectionView.register(collectionViewCellNib, forCellWithReuseIdentifier: "BookWarmCollectionViewCell")
        collectionView.bounces = false

        configureCollectionViewLayout()
        confgureNavBarButton()
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

        if searchBarState == .empty {
            return movieList.movie.count
        } else {
            return searchMovieList.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookWarmCollectionViewCell", for: indexPath) as! BookWarmCollectionViewCell
        
        cell.configureCellAttribute()
        
        if searchBarState == .empty {
            cell.showCellContents(movie: movieList.movie[indexPath.row])
        } else {
            cell.showCellContents(movie: searchMovieList[indexPath.row])
        }
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        
        if searchBarState == .empty {
            movieList.movie[sender.tag].like.toggle()
        } else {
            searchMovieList[sender.tag].like.toggle()
            for i in 0..<movieList.movie.count {
                if movieList.movie[i].title == searchMovieList[sender.tag].title {
                    movieList.movie[i].like.toggle()
                }
            }
        }
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        if searchBarState == .empty {
            vc.movieData = movieList.movie[indexPath.row]
        } else {
            vc.movieData = searchMovieList[indexPath.row]
        }

        vc.transitionTypeID = TransitionID.push
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension BookWardmCollectionViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchMovieList.removeAll()
        searchBar.text = ""
        searchBarState = .empty
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchMovieList.removeAll()
        for i in 0..<movieList.movie.count {
            if movieList.movie[i].title.contains(searchText) {
                searchMovieList.append(movieList.movie[i])
            }
        }
        
        if let characterCount = searchBar.text?.count {
            if characterCount == 0 {
                searchBarState = .empty
            } else {
                searchBarState = .filled
            }
        }
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
