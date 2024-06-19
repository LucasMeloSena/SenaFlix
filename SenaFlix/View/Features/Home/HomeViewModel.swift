//
//  HomeViewModel.swift
//  SenaFlix
//
//  Created by Lucas Sena on 18/06/24.
//

import Foundation

protocol MovieManagerDelegate {
    func didUpdateData(_ movieManager: MovieManager, _ movieModel: [Movie])
    func didHaveAnError(_ error: Error)
}

struct Response: Codable {
    let page: Int
    let results: [Results]
    let total_pages: Int
    let total_results: Int
}

struct Results: Codable {
    let backdrop_path: String
    let id: Int
    let original_title: String
    let overview: String
    let poster_path: String
    let adult: Bool
    let title: String
    let release_date: String
    let original_language: String
    let genre_ids: [Int]
    let popularity: Double
    let vote_average: Double
    let vote_count: Int
    let video: Bool
}

struct Movie {
    let backdrop_path: String
    let id: Int
    let name: String
}

struct MovieManager {
    let api_key = "3b60eddacb7025e1b48c11803ffc00a6"
    let baseUrl = "https://api.themoviedb.org/3/discover/movie?language=pt-br&page=1&sort_by=popularity.desc&api_key="
    let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    var delegate: MovieManagerDelegate?
    
    func fetchTrendingMovies() {
        let urlString = "\(baseUrl)\(api_key)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if (error != nil) {
                    delegate?.didHaveAnError(error!)
                    return
                }
                if let safeData = data {
                    if let movie = self.parseJSON(from: safeData) {
                        self.delegate?.didUpdateData(self, movie)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(from data: Data) -> [Movie]? {
        let decoder = JSONDecoder()
        var movies: [Movie] = []
        do {
            let decodedData = try decoder.decode(Response.self, from: data)
            for movie in decodedData.results {
                let id = movie.id
                let name = movie.title
                let movieImage = "\(baseImageUrl)\(movie.poster_path)"
                movies.append(Movie(backdrop_path: movieImage, id: id, name: name))
            }
            return movies
        }
        catch {
            delegate?.didHaveAnError(error)
            return nil
        }
    }
}
