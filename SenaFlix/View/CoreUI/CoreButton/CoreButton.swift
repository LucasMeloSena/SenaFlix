//
//  CoreButton.swift
//  SenaFlix
//
//  Created by Lucas Sena on 21/06/24.
//

import Foundation
import UIKit

class CoreButton: UIButton {
    let buttonBackgroundColor: UIColor
    let text: String
    let textColor: UIColor
    let buttonBorderColor: UIColor?
    let iconName: String?
    
    init(frame: CGRect = .zero, buttonBackgroundColor: UIColor, text: String, textColor: UIColor, buttonBorderColor: UIColor?, iconName: String?) {
        self.buttonBackgroundColor = buttonBackgroundColor
        self.text = text
        self.textColor = textColor
        self.buttonBorderColor = buttonBorderColor
        self.iconName = iconName
        
        super.init(frame: frame)
        
        self.applyStyle()
        self.applyText()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyStyle() {
        self.backgroundColor = buttonBackgroundColor
        self.layer.cornerRadius = 5
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 16)
        self.layer.borderColor = buttonBorderColor?.cgColor
        self.layer.borderWidth = 1
        if let icon = iconName {
            let image = UIImage(systemName: icon)
            self.tintColor = textColor
            self.setImage(image, for: .normal)
            self.configuration = .plain()
            self.configuration!.imagePadding = 10
        }
    }
    
    func applyText() {
        self.setTitle(text, for: .normal)
    }
}
