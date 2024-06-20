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
    
    private lazy var labelGloboPlay = CoreLabel(type: .title, color: .white, content: "globoplay")
    
    //MARK: - ACTIONS
    var movieManager = MovieManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadContraints()
        movieManager.delegate = self
        requestMoviesData()
    }
    
    private func setup() {
        view.addSubview(containerView)
        containerView.addSubview(labelGloboPlay)
        containerView.addSubview(stackViewTitlePoster)
    }
    
    private func loadContraints() {
        containerView.snp.makeConstraints {(make) -> Void in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        labelGloboPlay.snp.makeConstraints { make in
            make.top.equalTo(containerView.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
        }
        
        stackViewTitlePoster.snp.makeConstraints { make in
            make.top.equalTo(labelGloboPlay.snp_bottomMargin).offset(20)
            make.leading.equalTo(10)
            make.trailing.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    private func requestMoviesData() {
        let popularUrl = "https://api.themoviedb.org/3/movie/popular?language=pt-br&page=1&api_key="
        movieManager.fetchMovies(from: popularUrl, type: .popular)
        
        let topRatedUrl = "https://api.themoviedb.org/3/movie/top_rated?language=pt-br&page=1&api_key="
        movieManager.fetchMovies(from: topRatedUrl, type: .topRated)
    }
    
    private func populateView(movies: [Movie]) {
        let coreStack = CoreStack(stackViewTitlePoster: stackViewTitlePoster, movies: movies)
        coreStack.populateStackView()
    }
    
}


extension HomeViewController: MovieManagerDelegate {
    func didUpdateData(_ movieManager: MovieManager, _ movieModel: [Movie], _ movieType: MovieType) {
        if (movieType == .popular) {
            print("Populares")
            populateView(movies: movieModel)
        }
        else if (movieType == .topRated) {
            print("Bem avaliados")
            populateView(movies: movieModel)
        }
    }
    
    func didHaveAnError(_ error: any Error) {
        print("Error during getting movies, \(error)")
    }
}
