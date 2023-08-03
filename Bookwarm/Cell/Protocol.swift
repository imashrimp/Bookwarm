//
//  CellConfigureProtocol.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/08/03.
//

import UIKit

protocol CellConfigureProtocol {
    func showCellContents(movie: Movie)
}

protocol LikeButtonProtocol {
    func likeButtonTapped(_ sender: UIButton)
}

protocol CellFlowLayoutProtocol {
    func configureCollectionViewLayout()
}
