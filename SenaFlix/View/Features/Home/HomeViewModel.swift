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

struct MovieManager {
    let api_key: String = ProcessInfo.processInfo.environment["API_KEY"] ?? ""
    let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    struct Retorno {
        let movieManager: MovieManager?
        let movieModel: [Movie]?
        let movieType: MovieType?
        let error: Error?
    }
    
    func fetchMovies(from baseUrl: String, type: MovieType, completion: @escaping (Retorno) -> Void) {
        let request = CoreRequest(url: baseUrl, api_key: api_key)
        request.fetchData() { response in
            if response.error != nil {
                completion(Retorno(movieManager: nil, movieModel: nil, movieType: nil, error: response.error!))
                return
            }
            else if response.data != nil {
                if let movie = parseJSON(from: response.data!) {
                    completion(Retorno(movieManager: self, movieModel: movie, movieType: type, error: nil))
                    return
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
            print("Error during parsing json in movies fetch, \(error)")
            return nil
        }
    }
}

struct MovieDetailManager {
    let api_key: String = ProcessInfo.processInfo.environment["API_KEY"] ?? ""
    let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    
    func fetchMovieDetail(in url: String, from id: Int, completion: @escaping (MovieDetail?) -> Void) {
        let request = CoreRequest(url: url, api_key: api_key)
        request.fetchData { response in
            if response.error != nil {
                print("Error during getting movie data, \(response.error!)")
                completion(nil) 
            }
            if let data = response.data {
                parseJSONMovieDetail(from: data, id) { movieDetail in
                    if let movieInfo = movieDetail {
                        completion(movieInfo)
                    }
                }
            }
        }
    }
    
    func parseJSONMovieDetail(from data: Data, _ id: Int, completion: @escaping (MovieDetail?) -> Void) {
        let videoUrl = "https://api.themoviedb.org/3/movie/\(id)/videos?language=pt-br&api_key="
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MovieDetailResponse.self, from: data)
            
            var genres: [String] = []
            for genre in decodedData.genres {
                genres.append(genre.name)
            }
            let releaseDate = decodedData.release_date.components(separatedBy: "-")[0]
            let originCountry = decodedData.origin_country[0]
            let imageUrl = "\(baseImageUrl)\(decodedData.poster_path)"
            let studio = decodedData.production_companies[0].name
            
            fetchMovieTrailer(in: videoUrl) { videoUrl in
                let movieDetail = MovieDetail(id: decodedData.id, name: decodedData.title,  original_name: decodedData.original_title, genres: genres, overview: decodedData.overview, releaseDate: releaseDate, country: originCountry, video_url: videoUrl, poster_url: imageUrl, duration: decodedData.runtime, management: studio, budget: decodedData.budget, vote_average: decodedData.vote_average)
                completion(movieDetail)
                
            }
        } catch {
            print("Error during decoding movie detail data, \(error)")
            completion(nil)
        }
    }
    
    func fetchMovieTrailer(in url: String, completion: @escaping (String?) -> Void) {
        let request = CoreRequest(url: url, api_key: api_key)
        request.fetchData { response in
            if let error = response.error {
                print("Error fetching movie trailer: \(error.localizedDescription)")
                completion(nil)
                return
            }
            else if let data = response.data {
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(MovieVideoResponse.self, from: data)
                    guard let youtubeId = decodedData.results.first?.key else {
                        completion(nil)
                        return
                    }
                    let videoUrl = "https://www.youtube.com/watch?v=\(youtubeId)"
                    completion(videoUrl)
                } catch {
                    print("Error decoding movie trailer response: \(error.localizedDescription)")
                    completion(nil)
                }
            } else {
                print("Unexpected response without error or data")
                completion(nil)
            }
        }
    }
    
}
