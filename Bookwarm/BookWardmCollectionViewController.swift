//
//  BookWardmCollectionViewController.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/07/31.
//

import UIKit

class BookWardmCollectionViewController: UICollectionViewController {
    
    let movieList = MovieList()

    @IBOutlet var searchButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "새우의 책장"
        
        let nib = UINib(nibName: "BookWarmCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "BookWarmCollectionViewCell")

        setCollectionViewLayout()
        confgureNavigationBar()
        
    }
    
    
    @IBAction func searchButtonTapped(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController")
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
    
    
    func confgureNavigationBar() {
        searchButton.image = UIImage(systemName: "magnifyingglass")
        navigationController?.navigationBar.tintColor = .black
    }
    
    func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = (UIScreen.main.bounds.width - ( spacing * 3)) / 2
        
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.movie.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookWarmCollectionViewCell", for: indexPath) as! BookWarmCollectionViewCell
        
        cell.configureCellAttribute()
        cell.setUIContents(movie: movieList.movie[indexPath.row])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
//        vc.selectedMovie = movieList.movie[indexPath.row].title
        vc.selectedMovie = movieList.movie[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
