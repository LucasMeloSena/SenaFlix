//
//  MovieViewController.swift
//  SenaFlix
//
//  Created by Lucas Sena on 20/06/24.
//

import Foundation
import UIKit
import SnapKit

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
    
    private lazy var alsoWatchMovieCards = MovieCards(movies: movies!)
    
    //MARK: - ACTIONS
    var movie: MovieDetail?
    var movies: [Movie]?
    
    override func viewDidLoad() {
        setup()
        loadConstraints()
        setupNavigationController()
        
        movieOptions.delegate = self
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
