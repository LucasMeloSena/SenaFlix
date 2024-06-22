//
//  OptionsStack.swift
//  SenaFlix
//
//  Created by Lucas Sena on 21/06/24.
//

import Foundation
import UIKit

class OptionsStack: UIStackView {
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setup()
        loadConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    private lazy var labelWatchAlso = CoreLabel(type: .text, color: .white, content: "ASSISTA TAMBÉM")
    
    private lazy var labelDetails = CoreLabel(type: .text, color: .white, content: "DETALHES")
    
    //MARK: - ACTIONS
    private func setup() {
        self.addArrangedSubview(labelWatchAlso)
        self.addArrangedSubview(labelDetails)
    }
    
    private func loadConstraints() {
        self.axis = .horizontal
        self.distribution = .fill
        self.alignment = .leading
        self.spacing = 20
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
