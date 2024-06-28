//
//  MovieCards.swift
//  SenaFlix
//
//  Created by Lucas Sena on 23/06/24.
//

import Foundation
import UIKit

class CoreImageScroll: UIStackView {
    let movies: [Movie]
    var favoriteMovies: [Favorites]
    var delegate: CoreImageScrollDelegate?
    
    init(frame: CGRect = .zero, movies: [Movie] = [], favoriteMovies: [Favorites] = []) {
        self.movies = movies
        self.favoriteMovies = favoriteMovies
        
        super.init(frame: frame)
        setup()
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
                    currentRowStackView!.distribution = .fillEqually
                    currentRowStackView!.translatesAutoresizingMaskIntoConstraints = false
                    self.addArrangedSubview(currentRowStackView!)
                }
                if let url = URL(string: item.poster_url!) {
                    let image = CoreImageCard(id: Int(item.idMovie), url: url) { sender in
                        self.delegate?.handleClickStackItem(Int(item.idMovie))
                    }
                    currentRowStackView?.addArrangedSubview(image)
                    addWidthConstraint(to: image)
                }
            }
        }
        else if (favoriteMovies.count == 0) {
            for (index, item) in movies.enumerated() {
                if index % 2 == 0 {
                    currentRowStackView = UIStackView()
                    currentRowStackView!.axis = .horizontal
                    currentRowStackView!.spacing = 20
                    currentRowStackView!.distribution = .fillEqually
                    currentRowStackView!.translatesAutoresizingMaskIntoConstraints = false
                    self.addArrangedSubview(currentRowStackView!)
                }
                if let url = URL(string: item.backdrop_path) {
                    let image = CoreImageCard(id: item.id, url: url) { sender in
                        self.delegate?.handleClickStackItem(item.id)
                    }
                    currentRowStackView?.addArrangedSubview(image)
                    addWidthConstraint(to: image)
                }
            }
        }
    }
    
    private func addWidthConstraint(to view: UIView) {
        view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5, constant: -10).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func applyStyle() {
        self.axis = .vertical
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alignment = .fill
        self.distribution = .fillEqually
        self.spacing = 20
    }
    
    func updateMovies() {
        self.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for (index, item) in favoriteMovies.enumerated() {
            if index % 2 == 0 {
                currentRowStackView = UIStackView()
                currentRowStackView!.axis = .horizontal
                currentRowStackView!.spacing = 20
                currentRowStackView!.distribution = .fillEqually
                currentRowStackView!.translatesAutoresizingMaskIntoConstraints = false
                self.addArrangedSubview(currentRowStackView!)
            }
            if let url = URL(string: item.poster_url!) {
                let image = CoreImageCard(id: Int(item.idMovie), url: url) { sender in
                    self.delegate?.handleClickStackItem(Int(item.idMovie))
                }
                currentRowStackView?.addArrangedSubview(image)
                addWidthConstraint(to: image)
            }
        }
    }
}
