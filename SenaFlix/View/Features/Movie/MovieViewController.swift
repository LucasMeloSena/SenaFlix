//
//  MovieViewController.swift
//  SenaFlix
//
//  Created by Lucas Sena on 20/06/24.
//

import Foundation
import UIKit
import SnapKit
import CoreData

private enum ButtonState {
    case Normal
    case Favorite
}

class MovieViewController: UIViewController {
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
    
    private lazy var movieInfoStack = MovieWidget(from: movie!)
    
    private lazy var buttonsStack = ButtonsStack()
    
    private lazy var movieOptions = OptionsStack()
    
    private lazy var compiledData = CompiledData(movie: movie)
    
    private lazy var trailer = TrailerWidget(videoUrl: movie?.video_url)
    
    private lazy var alsoWatchMovieCards = CoreImageScroll(movies: movies!)
    
    //MARK: - ACTIONS
    var movie: MovieDetail?
    var movies: [Movie]?
    var coreDataManager = CoreDataController()
    var favoriteMovies = [Favorites]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        setup()
        loadConstraints()
        setupNavigationController()
        
        movieOptions.delegate = self
        coreDataManager.delegate = self
    
        loadFavoriteMovies(buttonsStack.detailsButton)
    }
    
    private func setup() {
        view.addSubview(containerView)
        containerView.addSubview(scrollView)
        scrollView.addSubview(mainVerticalStack)
        mainVerticalStack.addArrangedSubview(movieInfoStack)
        mainVerticalStack.addArrangedSubview(buttonsStack)
        mainVerticalStack.addArrangedSubview(movieOptions)
        mainVerticalStack.addArrangedSubview(compiledData)
    }
    
    private func setupNavigationController() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = UIColor(named: K.appColors.black600)
        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
    }
    
    private func loadConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
        
        mainVerticalStack.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        mainVerticalStack.setCustomSpacing(50, after: buttonsStack)
        
        buttonsStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        movieOptions.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        
        if movie?.video_url != nil {
            compiledData.addArrangedSubview(trailer)
            
            trailer.snp.makeConstraints { make in
                make.width.equalToSuperview()
                make.height.equalTo(300)
            }
        }
        
        if mainVerticalStack.arrangedSubviews.contains(alsoWatchMovieCards) {
            alsoWatchMovieCards.snp.makeConstraints { make in
                make.width.equalToSuperview().multipliedBy(0.8)
            }
        }
        else {
            compiledData.snp.makeConstraints { make in
                make.width.equalToSuperview().multipliedBy(0.9)
            }
        }
    }
    
    @objc private func favoritePressed(_ sender: UIButton) {
        if (sender.tag == 0) {
            changeButtonState(state: .Favorite, for: sender)
            
            let newItem = Favorites(context: self.context)
            newItem.idMovie = Int32(movie!.id)
            newItem.poster_url = movie!.poster_url
            favoriteMovies.append(newItem)
            coreDataManager.save(context)
        }
        else if (sender.tag == 1) {
            changeButtonState(state: .Normal, for: sender)
            
            let movieToRemove = favoriteMovies.first(where: { $0.idMovie == movie!.id })
            if let removeMovie = movieToRemove {
                favoriteMovies.removeAll(where: {$0.idMovie == movie!.id})
                let movieId = removeMovie.objectID
                coreDataManager.remove(context, from: movieId)
            }
        }
    }
    
    private func changeButtonState(state: ButtonState, for sender: UIButton) {
        if (state == .Normal) {
            let image = UIImage(systemName: "star.fill")
            sender.setTitle("Minha Lista", for: .normal)
            sender.setImage(image, for: .normal)
            sender.tag = 0
        }
        else if (state == .Favorite) {
            let image = UIImage(systemName: "checkmark")
            sender.setTitle("Adicionado", for: .normal)
            sender.setImage(image, for: .normal)
            sender.tag = 1
        }
    }
    
    private func loadFavoriteMovies(_ sender: UIButton) {
        buttonsStack.detailsButton.addTarget(self, action: #selector(favoritePressed), for: UIControl.Event.touchUpInside)
        
        coreDataManager.loadItems(context)
        
        for favoriteMovie in favoriteMovies {
            if (favoriteMovie.idMovie == movie!.id) {
                changeButtonState(state: .Favorite, for: sender)
            }
        }
    }
}

//MARK: - DELEGATE METHODS
extension MovieViewController: MovieOptionsDelegate {
    private func removeView(_ view: UIView) {
        mainVerticalStack.removeArrangedSubview(view)
        view.removeFromSuperview()
        mainVerticalStack.setNeedsLayout()
        mainVerticalStack.layoutIfNeeded()
    }
    
    private func appendView(_ view: UIView) {
        mainVerticalStack.addArrangedSubview(view)
        mainVerticalStack.setNeedsLayout()
        mainVerticalStack.layoutIfNeeded()
        loadConstraints()
    }
    
    func didOptionChanged(option: Options) {
        switch option {
        case .alsoWatch:
            removeView(compiledData)
            appendView(alsoWatchMovieCards)
        case .details:
            removeView(alsoWatchMovieCards)
            appendView(compiledData)
        }
    }
}

extension MovieViewController: CoreDataControllerDelegate {
    func loadFavoritesMovies(_ favoriteMovies: [Favorites]) {
        self.favoriteMovies = favoriteMovies
    }
}
