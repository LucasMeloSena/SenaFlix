//
//  FavoritesViewController.swift
//  SenaFlix
//
//  Created by Lucas Sena on 23/06/24.
//

import Foundation
import UIKit
import SnapKit

class FavoritesViewController: UIViewController {
    //MARK: - UI
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: K.appColors.black600)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private lazy var mainVerticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var labelMyList = CoreLabel(type: .title, color: .white, content: "Minha Lista")
    
    private var movieCards: CoreImageScroll?
    
    private lazy var labelNoFavorites = CoreLabel(type: .textBold, color: .white, content: "Não há nenhum filme favoritado!")
    
    //MARK: - ACTIONS
    var coreDataManager = CoreDataController()
    var coreMoviesRequest = CoreMoviesRequest()
    var movies = [Movie]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coreDataManager.delegate = self
        coreMoviesRequest.delegate = self
        coreMoviesRequest.requestMoviesData()
        
        setup()
        loadConstraints()
        applyStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movies = []
        coreDataManager.loadItems(context)
    }
    
    private func setup() {
        view.addSubview(containerView)
        containerView.addSubview(scrollView)
        scrollView.addSubview(mainVerticalStack)
    }
    
    private func loadConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
        
        mainVerticalStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
    }
    
    private func applyStyle() {
        navigationItem.titleView = labelMyList
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = UIColor(named: K.appColors.black600)
        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
    }
}

//MARK: - DELEGATE METHODS
extension FavoritesViewController: CoreDataControllerDelegate {
    func loadFavoritesMovies(_ favoriteMovies: [Favorites]) {
        mainVerticalStack.removeArrangedSubview(labelNoFavorites)
        labelNoFavorites.removeFromSuperview()
        mainVerticalStack.setNeedsLayout()
        mainVerticalStack.layoutIfNeeded()
        
        if (favoriteMovies.isEmpty) {
            mainVerticalStack.addArrangedSubview(labelNoFavorites)
        }
        
        if movieCards == nil {
            movieCards = CoreImageScroll(favoriteMovies: favoriteMovies)
            mainVerticalStack.addArrangedSubview(movieCards!)
        } else {
            movieCards!.favoriteMovies = favoriteMovies
            movieCards!.updateMovies()
        }
        movieCards?.delegate = self
    }
}

extension FavoritesViewController: CoreImageScrollDelegate {
    func handleClickStackItem(_ id: Int) {
        let coreMovieRequest = CoreMovieRequest()
        coreMovieRequest.requestMovieData(from: id) { movie in
            DispatchQueue.main.async {
                let movieViewController = MovieViewController()
                movieViewController.movie = movie
                movieViewController.movies = self.movies
                self.navigationController?.pushViewController(movieViewController, animated: true)
            }
        }
    }
}

extension FavoritesViewController: MovieManagerDelegate {
    func didUpdateData(_ movieManager: MovieManager, _ movieModel: [Movie], _ movieType: MovieType) {
        self.movies = movieModel
    }
    
    func didHaveAnError(_ error: any Error) {
        print("Error during getting movies in FavoritesViewController, \(error)")
    }
}
