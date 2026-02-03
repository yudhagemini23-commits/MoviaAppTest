//
//  MovieCellTableViewCell.swift
//  MoviaAppTest
//
//  Created by Yudha Pratama Putra on 2/4/26.
//

import UIKit
import SDWebImage

class MovieCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Sedikit styling biar manis
        posterImageView.layer.cornerRadius = 8
        posterImageView.clipsToBounds = true
    }

    // Fungsi konfigurasi data
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        
        // 1. Set Indikator Loading (Spinner)
        posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
        // 2. Load Gambar (Perbaikan baris yang error tadi)
        // Gunakan sd_setImage, bukan .s
        posterImageView.sd_setImage(
            with: movie.posterURL,
            placeholderImage: UIImage(systemName: "photo")
        )
    }
}
