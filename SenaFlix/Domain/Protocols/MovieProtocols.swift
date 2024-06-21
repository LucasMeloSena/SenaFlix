//
//  MoviesProtocols.swift
//  SenaFlix
//
//  Created by Lucas Sena on 20/06/24.
//

import Foundation

protocol MovieManagerDelegate {
    func didUpdateData(_ movieManager: MovieManager, _ movieModel: [Movie], _ movieType: MovieType)
    func didHaveAnError(_ error: Error)
}
