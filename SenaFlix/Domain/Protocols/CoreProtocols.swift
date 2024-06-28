//
//  MoviesProtocols.swift
//  SenaFlix
//
//  Created by Lucas Sena on 20/06/24.
//

import Foundation

//MARK: - MOVIE PROTOCOLS
protocol MovieManagerDelegate {
    func didUpdateData(_ movieManager: MovieManager, _ movieModel: [Movie], _ movieType: MovieType)
    func didHaveAnError(_ error: Error)
}

protocol MovieOptionsDelegate {
    func didOptionChanged(option: Options)
}

//MARK: - CORE DATA PROTOCOLS
protocol CoreDataControllerDelegate {
    func loadFavoritesMovies(_ favoriteMovies: [Favorites])
}

//MARK: - CORE UI PROTOCOLS
protocol CoreImageScrollDelegate {
    func handleClickStackItem(_ id: Int)
}

protocol CoreStackClickDelegate {
    func handleClickStackItem(_ id: Int)
}
