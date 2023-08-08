//
//  EditableTextView.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/08/04.
//

import UIKit

class EditableTextView: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
    }
}
