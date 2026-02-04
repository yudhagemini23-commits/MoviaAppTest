//
//  Movie.swift
//  MoviaAppTest
//
//  Created by Yudha Pratama Putra on 2/4/26.
//

import Foundation
import SwiftyJSON

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
        self.overview = json["overview"].stringValue
        self.posterPath = json["poster_path"].string
        self.releaseDate = json["release_date"].string
    }
    
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
}
