//
//  SearchViewController.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {

    var searchVCTitle: String = "검색화면"
    
    @IBOutlet var searchVCLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = searchVCTitle
        configureLabel()
        setXButton()
    }
    
    func configureLabel() {
        searchVCLabel.text = "검색화면"
        searchVCLabel.textAlignment = .center
        searchVCLabel.font = .systemFont(ofSize: 50, weight: .heavy)
    }
    
    func setXButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissModal))
    }

    @objc func dismissModal() {
        dismiss(animated: true)
    }
    
}
