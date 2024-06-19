//
//  CoreLabel.swift
//  SenaFlix
//
//  Created by Lucas Sena on 19/06/24.
//

import Foundation
import UIKit

enum LabelTypes {
    case title
    case subTitle
    case text
    case slowText
}

class CoreLabel: UILabel {
    let type: LabelTypes
    let color: UIColor
    let content: String
    
    init(frame: CGRect = .zero, type: LabelTypes, color: UIColor, content: String) {
        self.type = type
        self.color = color
        self.content = content
        
        super.init(frame: frame)
        
        self.applyStyle()
        self.applyText()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyStyle() {
        switch type {
        case .title:
            self.font = UIFont(name: "Poppins-Bold", size: 20)
        case .subTitle:
            self.font = UIFont(name: "Poppins-Medium", size: 18)
        case .text:
            self.font = UIFont(name: "Poppins-Regular", size: 16)
        case .slowText:
            self.font = UIFont(name: "Poppins-Regular", size: 14)
        }
        self.textColor = color
    }
    
    func applyText() {
        self.text = content
    }
}
