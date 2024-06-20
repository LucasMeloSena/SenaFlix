//
//  CoreStack.swift
//  SenaFlix
//
//  Created by Lucas Sena on 19/06/24.
//

import Foundation
import UIKit

class CoreStack {
    //MARK: - CONSTANTS
    var stackViewTitlePoster: UIStackView
    var movies: [Movie]
    
    init(stackViewTitlePoster: UIStackView, movies: [Movie]) {
        self.stackViewTitlePoster = stackViewTitlePoster
        self.movies = movies
    }
    
    //MARK: - UI
    private lazy var labelCategory = CoreLabel(type: .subTitle, color: .white, content: "Populares")
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackViewPosters: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - ACTIONS
    private func setup() {
        stackViewTitlePoster.addSubview(labelCategory)
        stackViewTitlePoster.addSubview(scrollView)
        scrollView.addSubview(stackViewPosters)
        
        labelCategory.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(5)
        }
        
        scrollView.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.top.equalTo(labelCategory.snp_bottomMargin).offset(20)
            make.bottom.equalTo(0)
        }
        
        stackViewPosters.snp.makeConstraints { make in
            make.leading.equalTo(5)
            make.trailing.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    func populateStackView() {
        setup()
        
        for movie in movies {
            guard let url = URL(string: movie.backdrop_path) else {
                fatalError("Invalid URL string.")
            }
            
            DispatchQueue.global().async {
                do {
                    let data = try Data(contentsOf: url)
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            let imageView = UIImageView()
                            imageView.translatesAutoresizingMaskIntoConstraints = false
                            imageView.image = image
                            imageView.layer.cornerRadius = 10
                            imageView.layer.masksToBounds = true
                            
                            imageView.snp.makeConstraints {(make) -> Void in
                                make.width.equalTo(150)
                                make.height.equalTo(200)
                            }
                            
                            self.stackViewPosters.addArrangedSubview(imageView)
                        }
                    } else {
                        print("Failed to create image from data")
                    }
                } catch {
                    print("Failed to load data from URL, \(error.localizedDescription)")
                }
            }
        }
    }
}
