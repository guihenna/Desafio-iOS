//
//  Movie.swift
//  Desafio - Mobile
//
//  Created by Guilherme de Almeida Henna on 23/10/18.
//  Copyright © 2018 Guilherme de Almeida Henna. All rights reserved.
//

import Foundation
import UIKit
import Mapper

class Movie: Mappable {
    
    fileprivate var _id: Int!
    fileprivate var _vote_average: Double!
    fileprivate var _title: String!
    fileprivate var _poster_url: String!
    fileprivate var _genres: [String]!
    fileprivate var _release_date: String!
    var id: Int {
        return _id
    }
    var vote_average: Double {
        return _vote_average
    }
    var title: String {
        return _title
    }
    var poster_url: String {
        return _poster_url
    }
    var genres: [String] {
        return _genres
    }
    var release_date: String {
        return _release_date
    }

    
    init(id: Int, vote_average: Double, title: String, poster_url: String, genres: [String], release_date: String) {
        self._id = id
        self._vote_average = vote_average
        self._title = title
        self._poster_url = poster_url
        self._genres = genres
        self._release_date = release_date

    }
    
    required init(map: Mapper) throws {
        try _id = map.from("id")
        try _vote_average = map.from("vote_average")
        try _title = map.from("title")
        try _poster_url = map.from("poster_url")
        try _genres = map.from("genres")
        try _release_date = map.from("release_date")
    }
}
