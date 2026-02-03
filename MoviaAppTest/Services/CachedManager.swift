//
//  CachedManager.swift
//  MoviaAppTest
//
//  Created by Yudha Pratama Putra on 2/4/26.
//

import Foundation

class CacheManager {
    static let shared = CacheManager()
    private let key = "cached_movies_list"
    
    // Simpan Array Movie ke Local Storage
    func saveMovies(_ movies: [Movie]) {
        if let encoded = try? JSONEncoder().encode(movies) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    // Ambil Data dari Local Storage
    func getCachedMovies() -> [Movie] {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([Movie].self, from: data) {
            return decoded
        }
        return []
    }
}
