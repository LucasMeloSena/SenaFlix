//
//  MovieCards.swift
//  SenaFlix
//
//  Created by Lucas Sena on 23/06/24.
//

import Foundation
import UIKit

class MovieCards: UIStackView {
    let movies: [Movie]
    
    init(frame: CGRect = .zero, movies: [Movie]) {
        self.movies = movies
        
        super.init(frame: frame)
        setup()
        loadConstraints()
        applyStyle()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    var currentRowStackView: UIStackView?
    
    //MARK: - ACTIONS
    private func setup() {
        for (index, item) in movies.enumerated() {
            if index % 2 == 0 {
                currentRowStackView = UIStackView()
                currentRowStackView!.axis = .horizontal
                currentRowStackView!.spacing = 20
                currentRowStackView!.distribution = .fill
                currentRowStackView!.translatesAutoresizingMaskIntoConstraints = false
                self.addArrangedSubview(currentRowStackView!)
            }
            if let url = URL(string: item.backdrop_path) {
                let image = CoreImageCard(id: item.id, url: url, imageMovieTapped: nil)
                currentRowStackView?.addArrangedSubview(image)
            }
        }
    }
    
    private func loadConstraints() {
        
    }
    
    private func applyStyle() {
        self.axis = .vertical
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = 20
    }
}
