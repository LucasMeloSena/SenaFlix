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
    
    private lazy var stackViewMovies: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var labelGloboPlay = CoreLabel(type: .title, color: .white, content: "globoplay")
    
    //MARK: - ACTIONS
    var movieManager = MovieManager()
    var popularMoviesStack: CoreStack!
    var topRatedMoviesStack: CoreStack!
    var movies: [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        loadContraints()
        
        movieManager.delegate = self
        requestMoviesData()
        
        navigationItem.titleView = labelGloboPlay
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.tabBarController?.selectedIndex = 1
        self.tabBarController?.tabBar.tintColor = .white
        self.tabBarController?.tabBar.barTintColor = .white
        self.tabBarController?.tabBar.unselectedItemTintColor = .white
        self.tabBarController?.tabBar.backgroundColor = .black.withAlphaComponent(0.3)
    }
    
    private func setup() {
        view.addSubview(containerView)
        containerView.addSubview(stackViewMovies)
        
        popularMoviesStack = CoreStack(labelCategory: "Populares")
        popularMoviesStack.delegate = self
        topRatedMoviesStack = CoreStack(labelCategory: "Bem Avaliados")
        topRatedMoviesStack.delegate = self
        
        stackViewMovies.addArrangedSubview(popularMoviesStack.getCurrentView())
        stackViewMovies.addArrangedSubview(topRatedMoviesStack.getCurrentView())
    }
    
    private func loadContraints() {
        containerView.snp.makeConstraints {(make) -> Void in
            make.edges.equalToSuperview()
        }
        
        stackViewMovies.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets).offset(80)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.trailing.bottom.equalToSuperview()
        }
    }
    
    private func requestMoviesData() {
        let popularUrl = "https://api.themoviedb.org/3/movie/popular?language=pt-br&page=1&api_key="
        movieManager.fetchMovies(from: popularUrl, type: .popular)
        
        let topRatedUrl = "https://api.themoviedb.org/3/movie/top_rated?language=pt-br&page=1&api_key="
        movieManager.fetchMovies(from: topRatedUrl, type: .topRated)
    }
    
    private func populateView(movies: [Movie], for category: MovieType) {
        switch category {
        case .popular:
            popularMoviesStack.movies = movies
            popularMoviesStack.populateStackView()
        case .topRated:
            topRatedMoviesStack.movies = movies
            topRatedMoviesStack.populateStackView()
        }
        self.movies = movies
    }
    
}

//MARK: - DELEGATE METHODS
extension HomeViewController: MovieManagerDelegate {
    func didUpdateData(_ movieManager: MovieManager, _ movieModel: [Movie], _ movieType: MovieType) {
        populateView(movies: movieModel, for: movieType)
    }
    
    func didHaveAnError(_ error: any Error) {
        print("Error during getting movies, \(error)")
    }
}

extension HomeViewController: CoreStackClickDelegate {
    func handleClickStackItem(_ id: Int) {
        let url = "https://api.themoviedb.org/3/movie/\(id)?language=pt-br&api_key="
        let movieDetailManager = MovieDetailManager()
        movieDetailManager.fetchMovieDetail(in: url, from: id) { data in
            if let movie = data, let lstMovies = self.movies {
                DispatchQueue.main.async {
                    let movieViewController = MovieViewController()
                    movieViewController.movie = movie
                    movieViewController.movies = lstMovies
                    self.navigationController?.pushViewController(movieViewController, animated: true)
                }
            }
        }
    }
}
