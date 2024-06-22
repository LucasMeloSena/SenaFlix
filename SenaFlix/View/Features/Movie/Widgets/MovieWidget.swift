//
//  MainMovieInfo.swift
//  SenaFlix
//
//  Created by Lucas Sena on 21/06/24.
//

import Foundation
import UIKit
import SnapKit

class MovieWidget: UIStackView {
    let movie: MovieDetail
    
    init(frame: CGRect = .zero, from movie: MovieDetail) {
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
    private lazy var movieImage = CoreImageCard(id: movie.id, url: URL(string: movie.poster_url)!, imageMovieTapped: nil)
    
    private lazy var titleLabel = CoreLabel(type: .title, color: .white, content: movie.name)
    
    private lazy var genre = CoreLabel(type: .slowText, color: .gray, content: movie.genres[0])
    
    private lazy var overview = CoreLabel(type: .text, color: .white, content: movie.overview)
    
    //MARK: - ACTIONS
    private func setup() {
        self.addArrangedSubview(movieImage)
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(genre)
        self.addArrangedSubview(overview)
    }
    
    private func loadConstraints() {
        overview.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
        }
    }
    
    private func applyStyle() {
        self.axis = .vertical
        self.alignment = .center
        self.distribution = .fill
        self.spacing = 10
        self.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textAlignment = .center
        overview.textAlignment = .justified
    }
}

//MARK: - DELEGATE METHODS

