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
    
    //MARK: - ACTIONS
    var movie: MovieDetail?
    
    override func viewDidLoad() {
        setup()
        loadConstraints()
        setupNavigationController()
    }
    
    private func setup() {
        view.addSubview(containerView)
        containerView.addSubview(scrollView)
        scrollView.addSubview(mainVerticalStack)
        mainVerticalStack.addArrangedSubview(movieInfoStack)
        mainVerticalStack.addArrangedSubview(buttonsStack)
        mainVerticalStack.addArrangedSubview(movieOptions)
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
        
        buttonsStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        movieOptions.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
    }
}

//MARK: - DELEGATE METHODS

