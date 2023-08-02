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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookshelfTableView.dataSource = self
        bookshelfTableView.delegate = self
        bookshelfTableView.rowHeight = 200
        self.navigationController?.navigationBar.isHidden = true
        
        let tableViewCellNib = UINib(nibName: "BookShelfTableViewCell", bundle: nil)
        bookshelfTableView.register(tableViewCellNib, forCellReuseIdentifier: "BookShelfTableViewCell")
    }
}

extension BookShelfViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(#function)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookShelfTableViewCell") as! BookShelfTableViewCell
        
        cell.showData(movie: movieList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        //여기서 데이터 전달
        
        present(nav, animated: true)
    }
    
}
