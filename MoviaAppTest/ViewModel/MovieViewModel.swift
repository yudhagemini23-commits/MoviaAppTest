//
//  MovieViewModel.swift
//  MoviaAppTest
//
//  Created by Yudha Pratama Putra on 2/4/26.
//

import Foundation

class MovieViewModel {
    
    var onUpdate: (() -> Void)?
    var onError: ((String) -> Void)?
    
    private var allMovies: [Movie] = []

    var displayedMovies: [Movie] = [] {
        didSet {
            self.onUpdate?()
        }
    }
    
    func loadData() {
        let cachedData = CacheManager.shared.getCachedMovies()
        if !cachedData.isEmpty {
            self.allMovies = cachedData
            self.displayedMovies = cachedData
        }
        
        APIService.shared.fetchPopularMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.allMovies = movies
                    self?.displayedMovies = movies
                    
                    CacheManager.shared.saveMovies(movies)
                    
                case .failure(let error):
                    if self?.allMovies.isEmpty ?? true {
                        self?.onError?(error.localizedDescription)
                    }
                }
            }
        }
    }
    
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
