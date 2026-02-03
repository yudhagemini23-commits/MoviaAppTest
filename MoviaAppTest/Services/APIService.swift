//
//  APIService.swift
//  MoviaAppTest
//
//  Created by Yudha Pratama Putra on 2/4/26.
//

import Foundation
import SwiftyJSON

class APIService {
    static let shared = APIService()
    
    // ⚠️ GANTI DENGAN API KEY ANDA DARI TMDB ⚠️
    private let apiKey = "63f0c91d338a102be02e9e2f38c3f9e5"
    
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            // 1. Cek Error Network
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // 2. Cek Data
            guard let data = data else { return }
            
            do {
                // 3. PARSING PAKAI SWIFTYJSON (Sesuai Request)
                let json = try JSON(data: data)
                let results = json["results"].arrayValue
                
                // Mapping Array JSON ke Array Movie
                let movies = results.map { Movie(json: $0) }
                
                completion(.success(movies))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
