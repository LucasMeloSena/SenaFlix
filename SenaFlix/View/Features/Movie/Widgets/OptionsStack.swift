//
//  OptionsStack.swift
//  SenaFlix
//
//  Created by Lucas Sena on 21/06/24.
//

import Foundation
import UIKit

enum Options {
    case alsoWatch
    case details
}

class OptionsStack: UIStackView {
    var delegate: MovieOptionsDelegate?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setup()
        applyStyle()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    private lazy var labelWatchAlso = CoreLabel(type: .text, color: .white, content: "ASSISTA TAMBÉM")
    
    private lazy var labelDetails = CoreLabel(type: .text, color: .white, content: "DETALHES")
    
    //MARK: - ACTIONS
    private func setup() {
        self.addArrangedSubview(labelDetails)
        self.addArrangedSubview(labelWatchAlso)
        labelDetails.changeLabelWeight(type: .textBold)
    }
    
    private func applyStyle() {        
        self.axis = .horizontal
        self.distribution = .fill
        self.alignment = .fill
        self.spacing = 20
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let detectWatchAction = UITapGestureRecognizer(target: self, action: #selector(handleWatchClicked))
        let detecDetailsAction = UITapGestureRecognizer(target: self, action: #selector(handleDetailsClicked))
        labelWatchAlso.addGestureRecognizer(detectWatchAction)
        labelDetails.addGestureRecognizer(detecDetailsAction)
        labelWatchAlso.isUserInteractionEnabled = true
        labelDetails.isUserInteractionEnabled = true
    }
    
    @objc private func handleWatchClicked() {
        labelDetails.changeLabelWeight(type: .text)
        labelWatchAlso.changeLabelWeight(type: .textBold)
        delegate?.didOptionChanged(option: .alsoWatch)
    }
    
    @objc private func handleDetailsClicked() {
        labelDetails.changeLabelWeight(type: .textBold)
        labelWatchAlso.changeLabelWeight(type: .text)
        delegate?.didOptionChanged(option: .details)
    }
}
