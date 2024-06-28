//
//  ButtonsStack.swift
//  SenaFlix
//
//  Created by Lucas Sena on 21/06/24.
//

import Foundation
import UIKit
import SnapKit

class ButtonsStack: UIStackView {
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setup()
        loadConstraints()
        applyStyle()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    private lazy var watchButton = CoreButton(buttonBackgroundColor: .white, text: "Asssita", textColor: .black, buttonBorderColor: nil, iconName: "play.fill")
    
    lazy var detailsButton = CoreButton(buttonBackgroundColor: UIColor(named: K.appColors.black600)!, text: "Minha Lista", textColor: .white, buttonBorderColor: .gray, iconName: "star.fill")
    
    
    //MARK: - ACTIONS
    private func setup() {
        self.addArrangedSubview(watchButton)
        self.addArrangedSubview(detailsButton)
    }
    
    private func loadConstraints() {
        watchButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.48)
            make.height.equalTo(50)
        }
        
        detailsButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.48)
            make.height.equalTo(50)
        }
    }
    
    private func applyStyle() {
        self.axis = .horizontal
        self.alignment = .center
        self.distribution = .fill
        self.spacing = 10
        self.isLayoutMarginsRelativeArrangement = false
        
        detailsButton.tag = 0
    }
}
