//
//  DetailsStack.swift
//  SenaFlix
//
//  Created by Lucas Sena on 22/06/24.
//

import Foundation
import UIKit

class DetailsStack: UIStackView {
    let titleInfo: String
    let info: String
    
    init(frame: CGRect = .zero, titleInfo: String, info: String) {
        self.titleInfo = titleInfo
        self.info = info
        
        super.init(frame: frame)
        
        setup()
        loadConstraints()
        applyStyle()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI    
    private lazy var labelTitleInfo = CoreLabel(type: .textBold, color: UIColor(named: K.appColors.gray300)!, content: titleInfo)
    
    private lazy var labelInfo = CoreLabel(type: .text, color: .gray, content: info)
    
    //MARK: - ACTIONS
    private func setup() {
        self.addArrangedSubview(labelTitleInfo)
        self.addArrangedSubview(labelInfo)
    }
    
    private func loadConstraints() {
        
    }
    
    private func applyStyle() {
        self.axis = .horizontal
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
