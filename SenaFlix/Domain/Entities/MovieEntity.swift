//
//  MovieEntity.swift
//  SenaFlix
//
//  Created by Lucas Sena on 20/06/24.
//

import Foundation

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

struct MovieDetailResponse: Codable {
    let adult: Bool
    let budget: Int
    let genres: [Genres]
    let id: Int
    let origin_country: [String]
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String
    let production_companies: [Companies]
    let production_countries: [Countries]
    let release_date: String
    let revenue: Double
    let runtime: Int
    let status: String
    let tagline: String
    let title: String
    let vote_average: Double
    let vote_count: Int
}

struct Countries: Codable {
    let iso_3166_1: String
    let name: String
}

struct Companies: Codable {
    let id: Int
    let logo_path: String?
    let name: String
    let origin_country: String
}

struct Genres: Codable {
    let id: Int
    let name: String
}

struct MovieDetail {
    let name: String
    let genres: [String]
    let overview: String
    let releaseDate: String
    let country: String
    let video_url: String
    let poster_url: String
}

struct MovieVideoResponse: Codable {
    let id: Int
    let results: [VideoInfo]
}

struct VideoInfo: Codable {
    let iso_639_1: String
    let iso_3166_1: String
    let name: String
    let key: String
    let site: String
    let size: Double
    let type: String
    let official: Bool
    let published_at: String
    let id: String
}
