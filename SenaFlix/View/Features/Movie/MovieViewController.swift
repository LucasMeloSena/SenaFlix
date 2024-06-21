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
        return view
    }()
    
    //MARK: - ACTIONS
    var movie: MovieDetail?
    
    override func viewDidLoad() {
        setup()
        loadConstraints()
        print(movie)
    }
    
    private func setup() {
        view.addSubview(containerView)
    }
    
    private func loadConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - DELEGATE METHODS

