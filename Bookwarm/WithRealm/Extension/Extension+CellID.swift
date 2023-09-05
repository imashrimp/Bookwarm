//
//  Extension+CellID.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/09/05.
//

import UIKit

extension UICollectionViewCell {
    
    static var id: String {
      return String(describing: self)
    }
}
