//
//  CustomTextView.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/09/05.
//

import UIKit

class CustomTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        font = .systemFont(ofSize: 15)
        isEditable = false
        textAlignment = .left
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}