//
//  CoreStack.swift
//  SenaFlix
//
//  Created by Lucas Sena on 19/06/24.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit

protocol CoreStackClickDelegate {
    func handleClickStackItem(_ id: Int)
}

class CoreStack {
    //MARK: - CONSTANTS
    var labelCatory: String
    var movies: [Movie]?
    var delegate: CoreStackClickDelegate?
    
    init(labelCategory: String) {
        self.labelCatory = labelCategory
        setup()
    }
    
    func getCurrentView() -> UIView {
        return self.containerView
    }
    
    //MARK: - UI
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackViewTitlePoster: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var labelCategory = CoreLabel(type: .subTitle, color: .white, content: labelCatory)
    
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
        containerView.addSubview(stackViewTitlePoster)
        stackViewTitlePoster.addArrangedSubview(labelCategory)
        stackViewTitlePoster.addArrangedSubview(scrollView)
        scrollView.addSubview(stackViewPosters)
        
        stackViewTitlePoster.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        labelCategory.snp.makeConstraints { make in
            make.leading.equalTo(5)
        }
        
        scrollView.snp.makeConstraints{(make) -> Void in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(labelCategory.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.height.equalTo(300)
        }
        
        stackViewPosters.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    func populateStackView() {
        guard let data = movies else {
            fatalError("Error during loading movies.")
        }
        
        for movie in data {
            guard let url = URL(string: movie.backdrop_path) else {
                fatalError("Invalid URL string.")
            }
            
            DispatchQueue.main.async {
                let imageView = UIImageView()
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.kf.setImage(with: url)
                imageView.layer.cornerRadius = 10
                imageView.layer.masksToBounds = true
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageMovieTapped(_:)))
                imageView.addGestureRecognizer(tapGesture)
                imageView.isUserInteractionEnabled = true
                imageView.tag = movie.id
                
                imageView.snp.makeConstraints {(make) -> Void in
                    make.width.equalTo(150)
                    make.height.equalTo(200)
                }
                
                self.stackViewPosters.addArrangedSubview(imageView)
            }
        }
    }
    
    @objc func imageMovieTapped(_ sender: UITapGestureRecognizer) {
        if let id = sender.view?.tag {
            delegate?.handleClickStackItem(id)
        }
    }
}
