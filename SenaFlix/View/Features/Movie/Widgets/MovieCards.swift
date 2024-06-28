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
    var favoriteMovies: [Favorites]
    
    init(frame: CGRect = .zero, movies: [Movie] = [], favoriteMovies: [Favorites] = []) {
        self.movies = movies
        self.favoriteMovies = favoriteMovies
        
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
        if (movies.count == 0) {
            for (index, item) in favoriteMovies.enumerated() {
                if index % 2 == 0 {
                    currentRowStackView = UIStackView()
                    currentRowStackView!.axis = .horizontal
                    currentRowStackView!.spacing = 20
                    currentRowStackView!.distribution = .fill
                    currentRowStackView!.translatesAutoresizingMaskIntoConstraints = false
                    self.addArrangedSubview(currentRowStackView!)
                }
                if let url = URL(string: item.poster_url!) {
                    let image = CoreImageCard(id: Int(item.idMovie), url: url, imageMovieTapped: nil)
                    currentRowStackView?.addArrangedSubview(image)
                }
            }
        }
        else if (favoriteMovies.count == 0) {
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
    
    func updateMovies() {
        self.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for (index, item) in favoriteMovies.enumerated() {
            if index % 2 == 0 {
                currentRowStackView = UIStackView()
                currentRowStackView!.axis = .horizontal
                currentRowStackView!.spacing = 20
                currentRowStackView!.distribution = .fill
                currentRowStackView!.translatesAutoresizingMaskIntoConstraints = false
                self.addArrangedSubview(currentRowStackView!)
            }
            if let url = URL(string: item.poster_url!) {
                let image = CoreImageCard(id: Int(item.idMovie), url: url, imageMovieTapped: nil)
                currentRowStackView?.addArrangedSubview(image)
            }
        }
    }
}
