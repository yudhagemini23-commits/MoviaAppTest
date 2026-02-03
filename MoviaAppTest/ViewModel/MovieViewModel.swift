//
//  MovieViewModel.swift
//  MoviaAppTest
//
//  Created by Yudha Pratama Putra on 2/4/26.
//

import Foundation

class MovieViewModel {
    
    // --- Binding ke View (Closures) ---
    var onUpdate: (() -> Void)?
    var onError: ((String) -> Void)?
    
    // --- Data Source ---
    private var allMovies: [Movie] = []
    
    // Data yang tampil di List (sudah kena filter search)
    var displayedMovies: [Movie] = [] {
        didSet {
            self.onUpdate?() // Kabari UI kalau data berubah
        }
    }
    
    // --- Fungsi Load Data (Cache First Strategy) ---
    func loadData() {
        // 1. LOAD CACHE DULU (Supaya UI langsung muncul walau offline)
        let cachedData = CacheManager.shared.getCachedMovies()
        if !cachedData.isEmpty {
            self.allMovies = cachedData
            self.displayedMovies = cachedData
        }
        
        // 2. FETCH API (Background Update)
        APIService.shared.fetchPopularMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.allMovies = movies
                    self?.displayedMovies = movies // Reset saat data baru masuk
                    
                    // Update Cache dengan data terbaru
                    CacheManager.shared.saveMovies(movies)
                    
                case .failure(let error):
                    // Hanya tampilkan error jika Cache Kosong & Internet Mati
                    if self?.allMovies.isEmpty ?? true {
                        self?.onError?(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    // --- Logic Search ---
    func searchMovie(query: String) {
        if query.isEmpty {
            displayedMovies = allMovies
        } else {
            displayedMovies = allMovies.filter { movie in
                movie.title.lowercased().contains(query.lowercased())
            }
        }
    }
}
