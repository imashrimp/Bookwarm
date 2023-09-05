//
//  CustomLabel.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/09/05.
//

import UIKit

class CustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        font = .systemFont(ofSize: 15)
        textAlignment = .left
        numberOfLines = 0
        
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
