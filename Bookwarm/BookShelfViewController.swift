//
//  BookShelfViewController.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/08/02.
//

import UIKit

class BookShelfViewController: UIViewController {

    
    @IBOutlet var bookshelfTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tableViewCellNib = UINib(nibName: "BookShelfTableViewCell", bundle: nil)
        bookshelfTableView.register(tableViewCellNib, forCellReuseIdentifier: "BookShelfTableViewCell")
    }
}

extension BookShelfViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookShelfTableViewCell") as! BookShelfTableViewCell
        
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
