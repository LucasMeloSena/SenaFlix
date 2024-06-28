//
//  Firebase.swift
//  SenaFlix
//
//  Created by Lucas Sena on 19/06/24.
//

import Foundation

struct CoreResponse {
    var data: Data?
    var error: Error?
}

struct CoreRequest {
    let url: String
    let api_key: String
    
    func fetchData(completion: @escaping (CoreResponse) -> Void) {
        var coreResponse = CoreResponse()
        let urlString = "\(url)\(api_key)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if (error != nil) {
                    coreResponse.error = error
                    completion(coreResponse)
                    return
                }
                if let safeData = data {
                    coreResponse.data = safeData
                    completion(coreResponse)
                    return
                }
            }
            task.resume()
        }
    }
}

struct CoreMovieRequest {
    func requestMovieData(from id: Int, completion: @escaping (MovieDetail) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)?language=pt-br&api_key="
        let movieDetailManager = MovieDetailManager()
        movieDetailManager.fetchMovieDetail(in: url, from: id) { data in
            if let movie = data {
                completion(movie)
            }
        }
    }
}

struct CoreMoviesRequest {
    var delegate: MovieManagerDelegate?
    let movieManager = MovieManager()
    
    func requestMoviesData() {
        let popularUrl = "https://api.themoviedb.org/3/movie/popular?language=pt-br&page=1&api_key="
        movieManager.fetchMovies(from: popularUrl, type: .popular) { data in
            if (data.error != nil) {
                delegate?.didHaveAnError(data.error!)
                return
            }
            delegate?.didUpdateData(data.movieManager!, data.movieModel!, data.movieType!)
        }
        
        let topRatedUrl = "https://api.themoviedb.org/3/movie/top_rated?language=pt-br&page=1&api_key="
        movieManager.fetchMovies(from: topRatedUrl, type: .topRated) { data in
            if (data.error != nil) {
                delegate?.didHaveAnError(data.error!)
                return
            }
            delegate?.didUpdateData(data.movieManager!, data.movieModel!, data.movieType!)
        }
    }
}
