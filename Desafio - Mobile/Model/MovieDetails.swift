//
//  MovieDetails.swift
//  Desafio - Mobile
//
//  Created by Guilherme de Almeida Henna on 26/10/18.
//  Copyright © 2018 Guilherme de Almeida Henna. All rights reserved.
//

import Foundation
import UIKit
import Mapper

class MovieDetails: Movie {
    
    fileprivate var _overview: String!
    fileprivate var _backdrop_url: String!
    fileprivate var _original_title: String!
    fileprivate var _id: Int!
    fileprivate var _vote_average: Double!
    fileprivate var _title: String!
    fileprivate var _poster_url: String!
    fileprivate var _genres: [String]!
    fileprivate var _release_date: String!
    
    var overview: String {
        return _overview
    }
    var backdrop_url: String {
        return _backdrop_url
    }
    var original_title: String {
        return _original_title
    }
    
    init(id: Int, vote_average: Double, title: String, poster_url: String, genres: [String], release_date: String, overview: String, backdrop_url: String, original_title: String) {
        super.init(id: id, vote_average: vote_average, title: title, poster_url: poster_url, genres: genres, release_date: release_date)
        
        self._overview = overview
        self._backdrop_url = backdrop_url
        self._original_title = original_title
    }
    
    required init(map: Mapper) throws {
        try super.init(map: map)
        
        try _overview = map.from("overview")
        try _backdrop_url = map.from("backdrop_url")
        try _original_title = map.from("original_title")
    }

}
