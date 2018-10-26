//
//  MovieCell.swift
//  Desafio - Mobile
//
//  Created by Guilherme de Almeida Henna on 23/10/18.
//  Copyright © 2018 Guilherme de Almeida Henna. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(_ movie: Movie) {
        movieTitle.text = movie.title
        movieInfo.text = "Movie ID: \(movie.id)\nVote average: \(movie.vote_average)\nRelease: \(movie.release_date)"
        let image = UIImage(named: "default")
        movieImg.kf.setImage(with: URL(string: movie.poster_url), placeholder: image)
    }
}
