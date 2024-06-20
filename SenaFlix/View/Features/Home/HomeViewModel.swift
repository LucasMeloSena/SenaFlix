//
//  HomeViewModel.swift
//  SenaFlix
//
//  Created by Lucas Sena on 18/06/24.
//

import Foundation

enum MovieType {
    case popular
    case topRated
}

protocol MovieManagerDelegate {
    func didUpdateData(_ movieManager: MovieManager, _ movieModel: [Movie], _ movieType: MovieType)
    func didHaveAnError(_ error: Error)
}

struct MovieResponse: Codable {
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
    let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    var delegate: MovieManagerDelegate?
    
    func fetchMovies(from baseUrl: String, type: MovieType) {
        let request = CoreRequest(url: baseUrl, api_key: api_key)
        request.fetchData() { response in
            if response.error != nil {
                delegate?.didHaveAnError(response.error!)
                return
            }
            else if response.data != nil {
                if let movie = parseJSON(from: response.data!) {
                    delegate?.didUpdateData(self, movie, type)
                }
            }
        }
    }
    
    func parseJSON(from data: Data) -> [Movie]? {
        let decoder = JSONDecoder()
        var movies: [Movie] = []
        do {
            let decodedData = try decoder.decode(MovieResponse.self, from: data)
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
