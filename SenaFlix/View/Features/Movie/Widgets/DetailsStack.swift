//
//  DetailsStack.swift
//  SenaFlix
//
//  Created by Lucas Sena on 22/06/24.
//

import Foundation
import UIKit
import SnapKit

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

class CompiledData: UIStackView {
    let movie: MovieDetail?
    
    init(frame: CGRect = .zero, movie: MovieDetail?) {
        self.movie = movie
        
        super.init(frame: frame)
        
        setup()
        loadConstraints()
        applyStyle()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    
    private lazy var labelTechSheet = CoreLabel(type: .subTitle, color: .white, content: "Ficha Técnica")
    
    private lazy var originalName = DetailsStack(titleInfo: "Nome Original:", info: movie!.original_name)
    
    private lazy var genres = DetailsStack(titleInfo: "Gênero:", info: movie!.genres[0])
    
    private lazy var duration = DetailsStack(titleInfo: "Duração:", info: "\(movie!.duration)min")
    
    private lazy var releaseYear = DetailsStack(titleInfo: "Ano de Produção:", info: movie!.releaseDate.components(separatedBy: "-")[0])
    
    private lazy var country = DetailsStack(titleInfo: "País:", info: movie!.country)
    
    private lazy var management = DetailsStack(titleInfo: "Direção:", info: movie!.management)
    
    private lazy var budget = DetailsStack(titleInfo: "Custo:", info: "$\(movie!.budget)")
    
    private lazy var votes = DetailsStack(titleInfo: "Média de Votos:", info: String(movie!.vote_average))
    
    //MARK: - ACTIONS
    private func setup() {
        self.addArrangedSubview(labelTechSheet)
        self.addArrangedSubview(originalName)
        self.addArrangedSubview(genres)
        self.addArrangedSubview(duration)
        self.addArrangedSubview(releaseYear)
        self.addArrangedSubview(country)
        self.addArrangedSubview(management)
        self.addArrangedSubview(budget)
        self.addArrangedSubview(votes)
    }
    
    private func loadConstraints() {
        self.setCustomSpacing(20, after: votes)
    }
    
    private func applyStyle() {
        self.axis = .vertical
        self.spacing = 5
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
