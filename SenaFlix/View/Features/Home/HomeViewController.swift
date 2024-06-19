//
//  HomeViewController.swift
//  SenaFlix
//
//  Created by Lucas Sena on 18/06/24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    //MARK: - UI
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: K.appColors.black600)
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
    
    private lazy var labelCategory = CoreLabel(type: .title, color: .white, content: "Populares")
    
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
    var movieManager = MovieManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadContraints()
        movieManager.delegate = self
        movieManager.fetchTrendingMovies()
    }
    
    private func setup() {
        view.addSubview(containerView)
        containerView.addSubview(stackViewTitlePoster)
        stackViewTitlePoster.addArrangedSubview(labelCategory)
        containerView.addSubview(scrollView)
        scrollView.addSubview(stackViewPosters)
    }
    
    private func loadContraints() {
        containerView.snp.makeConstraints {(make) -> Void in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        scrollView.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.top.equalTo(100)
            make.bottom.equalTo(0)
        }
        
        stackViewTitlePoster.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalTo(10)
        }
        
        stackViewPosters.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.trailing.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    private func populateStackView(movies: [Movie]) {
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

extension HomeViewController: MovieManagerDelegate {
    func didUpdateData(_ movieManager: MovieManager, _ movieModel: [Movie]) {
        populateStackView(movies: movieModel)
    }
    
    func didHaveAnError(_ error: any Error) {
        print("Error during getting movies, \(error)")
    }
}
