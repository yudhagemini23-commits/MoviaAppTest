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
        posterImageView.layer.cornerRadius = 8
        posterImageView.clipsToBounds = true
    }

    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        
        posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
        posterImageView.sd_setImage(
            with: movie.posterURL,
            placeholderImage: UIImage(systemName: "photo")
        )
    }
}
